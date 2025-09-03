#!/bin/bash

# Clean Architecture Feature Generator for Flutter with Beamer Integration
# Usage: ./generate_feature.sh [project_path] <feature_name> <entity_name> [package_name]
# Examples:
#   ./generate_feature.sh /path/to/flutter_project account Account com.example.app
#   ./generate_feature.sh account Account   # uses current directory and default package

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Function to extract package name from pubspec.yaml
get_package_name() {
    local project_path="$1"
    local pubspec_file="$project_path/pubspec.yaml"
    
    if [ -f "$pubspec_file" ]; then
        # Extract package name from pubspec.yaml
        local package_name=$(grep "^name:" "$pubspec_file" | sed 's/name: *//g' | tr -d ' ')
        if [ -n "$package_name" ]; then
            echo "$package_name"
            return 0
        fi
    fi
    
    # Fallback to default if pubspec.yaml not found or no name field
    echo "app"
    return 1
}

# Parse arguments
if [ $# -eq 4 ]; then
    PROJECT_PATH=$1
    FEATURE_NAME=$(echo "$2" | tr '[:upper:]' '[:lower:]')
    ENTITY_NAME=$3
    PACKAGE_NAME=$4
elif [ $# -eq 3 ]; then
    # Check if third argument is a path or package name
    if [ -d "$1" ]; then
        PROJECT_PATH=$1
        FEATURE_NAME=$(echo "$2" | tr '[:upper:]' '[:lower:]')
        ENTITY_NAME=$3
        PACKAGE_NAME=$(get_package_name "$PROJECT_PATH")
    else
        PROJECT_PATH="$PWD"
        FEATURE_NAME=$(echo "$1" | tr '[:upper:]' '[:lower:]')
        ENTITY_NAME=$2
        PACKAGE_NAME=$3
    fi
elif [ $# -eq 2 ]; then
    PROJECT_PATH="$PWD"
    FEATURE_NAME=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    ENTITY_NAME=$2
    PACKAGE_NAME=$(get_package_name "$PROJECT_PATH")
else
    echo "Usage: $0 [project_path] <feature_name> <entity_name> [package_name]"
    echo "Examples:"
    echo "  $0 account Account                    # uses current directory and pubspec.yaml"
    echo "  $0 /path/to/project account Account  # uses project path and pubspec.yaml"
    echo "  $0 account Account com.example.app   # uses current directory with custom package"
    echo "  $0 /path/to/project account Account com.example.app  # full custom"
    exit 1
fi

# Case formats
FEATURE_PASCAL=$(echo "${FEATURE_NAME:0:1}" | tr '[:lower:]' '[:upper:]')${FEATURE_NAME:1}
ENTITY_LOWER=$(echo "$ENTITY_NAME" | tr '[:upper:]' '[:lower:]')
ENTITY_PASCAL="$ENTITY_NAME"
ENTITY_CAMEL=$(echo "${ENTITY_NAME:0:1}" | tr '[:upper:]' '[:lower:]')${ENTITY_NAME:1}
FEATURE_CAMEL=$(echo "${FEATURE_NAME:0:1}" | tr '[:lower:]' '[:upper:]')${FEATURE_NAME:1}
FEATURE_CAMEL=$(echo "${FEATURE_CAMEL:0:1}" | tr '[:upper:]' '[:lower:]')${FEATURE_CAMEL:1}

FEATURE_DIR="$PROJECT_PATH/lib/features/$FEATURE_NAME"
TEMPLATES_DIR="$(dirname "$0")/templates"
LOCATION_PROVIDER_FILE="$PROJECT_PATH/lib/core/services/location_provider.dart"
LOCATION_PROVIDER_MAIN_FILE="$PROJECT_PATH/lib/core/services/location_provider.main.dart"
ROUTER_DELEGATE_FILE="$PROJECT_PATH/lib/core/services/router_delegate.dart"

print_status "Generating: $FEATURE_PASCAL with entity: $ENTITY_PASCAL"
print_status "Package: $PACKAGE_NAME"

# Create directories
mkdir -p "$FEATURE_DIR/data/datasources"
mkdir -p "$FEATURE_DIR/data/models"
mkdir -p "$FEATURE_DIR/data/repositories"
mkdir -p "$FEATURE_DIR/domain/entities"
mkdir -p "$FEATURE_DIR/domain/repositories"
mkdir -p "$FEATURE_DIR/domain/usecases"
mkdir -p "$FEATURE_DIR/presentation/bloc/$FEATURE_NAME"
mkdir -p "$FEATURE_DIR/presentation/pages"
mkdir -p "$FEATURE_DIR/presentation/widgets"

# Create core/services directory if it doesn't exist
mkdir -p "$(dirname "$LOCATION_PROVIDER_FILE")"

# Generate files function
generate_file() {
    local template="$1"
    local output="$2"
    sed -e "s/{{FEATURE_NAME}}/$FEATURE_NAME/g" \
        -e "s/{{FEATURE_PASCAL}}/$FEATURE_PASCAL/g" \
        -e "s/{{FEATURE_CAMEL}}/$FEATURE_CAMEL/g" \
        -e "s/{{ENTITY_NAME}}/$ENTITY_LOWER/g" \
        -e "s/{{ENTITY_PASCAL}}/$ENTITY_PASCAL/g" \
        -e "s/{{ENTITY_CAMEL}}/$ENTITY_CAMEL/g" \
        -e "s/{{PACKAGE_NAME}}/$PACKAGE_NAME/g" \
        "$TEMPLATES_DIR/$template" > "$output"
    print_status "✓ $(basename $output)"
}

# Generate all the existing files...
# Domain layer
generate_file "entity.dart" "$FEATURE_DIR/domain/entities/$ENTITY_LOWER.dart"
generate_file "repository.dart" "$FEATURE_DIR/domain/repositories/${FEATURE_NAME}_repository.dart"
generate_file "get_usecase.dart" "$FEATURE_DIR/domain/usecases/get_${ENTITY_LOWER}_usecase.dart"
generate_file "create_usecase.dart" "$FEATURE_DIR/domain/usecases/create_${ENTITY_LOWER}_usecase.dart"
generate_file "update_usecase.dart" "$FEATURE_DIR/domain/usecases/update_${ENTITY_LOWER}_usecase.dart"
generate_file "delete_usecase.dart" "$FEATURE_DIR/domain/usecases/delete_${ENTITY_LOWER}_usecase.dart"

# Data layer
generate_file "model.dart" "$FEATURE_DIR/data/models/${ENTITY_LOWER}_model.dart"
generate_file "datasource.dart" "$FEATURE_DIR/data/datasources/${FEATURE_NAME}_remote_datasource.dart"
generate_file "repository_impl.dart" "$FEATURE_DIR/data/repositories/${FEATURE_NAME}_repository_impl.dart"

# Presentation layer - Bloc
generate_file "bloc.dart" "$FEATURE_DIR/presentation/bloc/$FEATURE_NAME/${FEATURE_NAME}_bloc.dart"
generate_file "event.dart" "$FEATURE_DIR/presentation/bloc/$FEATURE_NAME/${FEATURE_NAME}_event.dart"
generate_file "state.dart" "$FEATURE_DIR/presentation/bloc/$FEATURE_NAME/${FEATURE_NAME}_state.dart"

# Presentation layer - Pages
generate_file "page.dart" "$FEATURE_DIR/presentation/pages/${FEATURE_NAME}_page.dart"

# Generate error page if it doesn't exist
ERROR_PAGE_FILE="$PROJECT_PATH/lib/core/common/views/error_page.dart"
if [ ! -f "$ERROR_PAGE_FILE" ]; then
    mkdir -p "$(dirname "$ERROR_PAGE_FILE")"
    generate_file "error_page.dart" "$ERROR_PAGE_FILE"
    print_status "Created error_page.dart"
fi

# Note: Beamer location will be added to location_provider.main.dart instead of separate file

# Smart file update functions
ensure_newline_at_end() {
    local file="$1"
    if [ -f "$file" ] && [ -s "$file" ]; then
        # Simple approach: always add a newline at the end, sed will handle duplicates
        echo "" >> "$file"
    fi
}
add_import_if_missing() {
    local file="$1"
    local import_line="$2"
    
    if [ -f "$file" ]; then
        if ! grep -Fq "$import_line" "$file"; then
            # Find the last import line and add after it
            if grep -q "^import" "$file"; then
                # Get the line number of the last import
                local last_import_line=$(grep -n "^import.*dart';" "$file" | tail -1 | cut -d: -f1)
                if [ -n "$last_import_line" ]; then
                    sed -i "" "${last_import_line}a\\
$import_line" "$file"
                    print_status "Added import to $(basename "$file")"
                else
                    # Fallback: add after first import
                    sed -i "" "/^import.*dart';$/a\\
$import_line" "$file"
                    print_status "Added import to $(basename "$file")"
                fi
            else
                # Add at the beginning if no imports exist, after any library declarations
                if grep -q "^library\|^part of" "$file"; then
                    sed -i "" "/^library.*\|^part of.*/a\\
\\
$import_line" "$file"
                else
                    sed -i "" "1i\\
$import_line\\
" "$file"
                fi
                print_status "Added first import to $(basename "$file")"
            fi
            return 0
        else
            print_status "Import already exists in $(basename "$file")"
            return 1
        fi
    fi
    return 2
}

add_to_location_list() {
    local file="$1"
    local location_class="$2"
    
    if [ -f "$file" ]; then
        if ! grep -q "$location_class" "$file"; then
            # Find beamLocations array and add before closing bracket
            if grep -q "beamLocations:" "$file"; then
                # Look for the closing bracket of beamLocations array more precisely
                local closing_bracket_line=$(grep -n "^\s*],*$\|^\s*\],$" "$file" | head -1 | cut -d: -f1)
                if [ -n "$closing_bracket_line" ]; then
                    # Insert before the closing bracket with proper indentation
                    sed -i "" "${closing_bracket_line}i\\
      $location_class," "$file"
                    print_status "Added $location_class to router delegate"
                    return 0
                else
                    # Enhanced fallback: look for any ], pattern
                    if grep -q "],\s*$\|],$" "$file"; then
                        sed -i "" "/],*$/i\\
      $location_class," "$file"
                        print_status "Added $location_class to router delegate"
                        return 0
                    fi
                fi
            fi
        else
            print_status "Location already exists in router delegate"
            return 1
        fi
    fi
    return 2
}

add_location_to_main_file() {
    local file="$1"
    local location_tmp_file="$2"
    
    if [ -f "$file" ] && [ -f "$location_tmp_file" ]; then
        if ! grep -q "${FEATURE_PASCAL}Location" "$file"; then
            # Add proper spacing and append the location class from temp file
            echo "" >> "$file"
            cat "$location_tmp_file" >> "$file"
            echo "" >> "$file"
            print_status "Added ${FEATURE_PASCAL}Location to location_provider.main.dart"
            return 0
        else
            print_status "Location already exists in location_provider.main.dart"
            return 1
        fi
    fi
    return 2
}

add_error_location_to_main_file() {
    local file="$1"
    
    if [ -f "$file" ]; then
        if ! grep -q "ErrorPageLocation" "$file"; then
            # Create temporary file with ErrorPageLocation class
            cat > /tmp/error_location.tmp << 'EOF'

class ErrorPageLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [ErrorPage.beamLocation];
  }

  @override
  List<Pattern> get pathPatterns => [ErrorPage.path];
}
EOF
            
            # Find the part declaration and add after it
            if grep -q "^part of" "$file"; then
                local part_line=$(grep -n "^part of" "$file" | head -1 | cut -d: -f1)
                # Create new file with content before part line, error location, then rest
                head -n "$part_line" "$file" > /tmp/new_main.tmp
                cat /tmp/error_location.tmp >> /tmp/new_main.tmp
                tail -n +$((part_line + 1)) "$file" >> /tmp/new_main.tmp
                mv /tmp/new_main.tmp "$file"
            else
                # If no part declaration, add at the beginning
                cat /tmp/error_location.tmp "$file" > /tmp/new_main.tmp
                mv /tmp/new_main.tmp "$file"
            fi
            rm -f /tmp/error_location.tmp
            print_status "Added ErrorPageLocation to location_provider.main.dart"
            return 0
        else
            print_status "ErrorPageLocation already exists in location_provider.main.dart"
            return 1
        fi
    fi
    return 2
}

add_error_location_to_router() {
    local file="$1"
    
    if [ -f "$file" ]; then
        if ! grep -q "ErrorPageLocation()" "$file"; then
            if grep -q "beamLocations:" "$file"; then
                # Find the line with beamLocations: [ and add ErrorPageLocation as first item
                local beam_locations_line=$(grep -n "beamLocations: \[" "$file" | cut -d: -f1)
                if [ -n "$beam_locations_line" ]; then
                    # Insert ErrorPageLocation() after the opening bracket
                    sed -i "" "${beam_locations_line}a\\
      ErrorPageLocation()," "$file"
                    print_status "Added ErrorPageLocation to router delegate"
                    return 0
                fi
            fi
        else
            print_status "ErrorPageLocation already exists in router delegate"
            return 1
        fi
    fi
    return 2
}

update_router_error_redirect() {
    local file="$1"
    
    if [ -f "$file" ]; then
        # Add error page import if missing
        add_import_if_missing "$file" "import 'package:$PACKAGE_NAME/core/common/views/error_page.dart';" || true
        
        # Add ErrorPageLocation to beamLocations if missing
        add_error_location_to_router "$file" || true
        
        # Update notFoundRedirectNamed to use ErrorPage.path if it's using InitPage.path or other paths
        if grep -q "notFoundRedirectNamed:" "$file" && ! grep -q "notFoundRedirectNamed: ErrorPage.path" "$file"; then
            sed -i "" "s/notFoundRedirectNamed: [^,]*/notFoundRedirectNamed: ErrorPage.path/g" "$file" || true
            print_status "Updated notFoundRedirectNamed to use ErrorPage"
        else
            print_status "Router already uses ErrorPage for not found redirects"
        fi
        print_status "Completed router_delegate.dart updates"
    fi
}

create_location_provider_template() {
    local file="$1"
    cat > "$file" << EOF
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:$PACKAGE_NAME/core/common/views/error_page.dart';
import 'package:$PACKAGE_NAME/features/$FEATURE_NAME/presentation/pages/${FEATURE_NAME}_page.dart';

part 'location_provider.main.dart';
EOF
    print_success "Created location_provider.dart template"
}

create_location_provider_main_template() {
    local file="$1"
    cat > "$file" << EOF
part of 'location_provider.dart';

class ErrorPageLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [ErrorPage.beamLocation];
  }

  @override
  List<Pattern> get pathPatterns => [ErrorPage.path];
}

class ${FEATURE_PASCAL}Location extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [${FEATURE_PASCAL}Page.beamLocation];
  }

  @override
  List<Pattern> get pathPatterns => [${FEATURE_PASCAL}Page.path];
}
EOF
    print_success "Created location_provider.main.dart template"
}

create_router_delegate_template() {
    local file="$1"
    cat > "$file" << EOF
import 'package:beamer/beamer.dart';
import 'package:$PACKAGE_NAME/core/services/location_provider.dart';
import 'package:$PACKAGE_NAME/core/common/views/error_page.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: BeamerLocationBuilder(
    beamLocations: [
      ErrorPageLocation(),
      ${FEATURE_PASCAL}Location(),
    ],
  ).call,
  notFoundRedirectNamed: ErrorPage.path,
);
EOF
    print_success "Created router_delegate.dart template"
}

# Handle Beamer Location Registration
print_status "Handling Beamer location registration..."

# Define the entries to add
IMPORT_LINE="import 'package:$PACKAGE_NAME/features/$FEATURE_NAME/presentation/pages/${FEATURE_NAME}_page.dart';"
LOCATION_CLASS="${FEATURE_PASCAL}Location()"

# Create a temporary file with the location content
cat > /tmp/location_content.tmp << EOF
class ${FEATURE_PASCAL}Location extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [${FEATURE_PASCAL}Page.beamLocation];
  }

  @override
  List<Pattern> get pathPatterns => [${FEATURE_PASCAL}Page.path];
}
EOF

print_status "Created location content for ${FEATURE_PASCAL}Location"

# Handle location_provider.dart
if [ ! -f "$LOCATION_PROVIDER_FILE" ]; then
    print_status "Creating location_provider.dart from template"
    create_location_provider_template "$LOCATION_PROVIDER_FILE"
else
    print_status "Updating existing location_provider.dart"
    add_import_if_missing "$LOCATION_PROVIDER_FILE" "$IMPORT_LINE" || true
fi
print_status "Completed location_provider.dart processing"

# Handle location_provider.main.dart
if [ ! -f "$LOCATION_PROVIDER_MAIN_FILE" ]; then
    print_status "Creating location_provider.main.dart from template"
    create_location_provider_main_template "$LOCATION_PROVIDER_MAIN_FILE"
else
    print_status "Updating existing location_provider.main.dart"
    # Add ErrorPageLocation if missing (but don't hang if it exists)
    add_error_location_to_main_file "$LOCATION_PROVIDER_MAIN_FILE" || true
    
    # Always try to add the new feature location
    if [ -f "/tmp/location_content.tmp" ]; then
        print_status "Adding ${FEATURE_PASCAL}Location to existing file"
        add_location_to_main_file "$LOCATION_PROVIDER_MAIN_FILE" "/tmp/location_content.tmp" || true
    else
        print_status "Warning: Location content template not found"
    fi
    print_status "Completed location_provider.main.dart updates"
fi

# Handle router_delegate.dart
if [ ! -f "$ROUTER_DELEGATE_FILE" ]; then
    print_status "Creating router_delegate.dart from template"
    create_router_delegate_template "$ROUTER_DELEGATE_FILE"
else
    print_status "Updating existing router_delegate.dart"
    add_to_location_list "$ROUTER_DELEGATE_FILE" "$LOCATION_CLASS"
    update_router_error_redirect "$ROUTER_DELEGATE_FILE"
fi

# Clean up file formatting
ensure_newline_at_end "$LOCATION_PROVIDER_FILE"
ensure_newline_at_end "$LOCATION_PROVIDER_MAIN_FILE"  
ensure_newline_at_end "$ROUTER_DELEGATE_FILE"

# Clean up temporary files
rm -f /tmp/location_content.tmp /tmp/error_location.tmp /tmp/new_main.tmp

print_success "Feature '$FEATURE_PASCAL' generated with intelligent Beamer integration!"

# Run build_runner to generate model code
print_status "Running build_runner to generate model code..."
cd "$PROJECT_PATH"
if dart run build_runner build --delete-conflicting-outputs; then
    print_success "Model code generated successfully!"
else
    echo "Warning: build_runner failed. You may need to run it manually."
fi

echo ""
echo "Files created/updated:"
echo "✓ Feature files in: lib/features/$FEATURE_NAME/"
echo "✓ Updated/created: lib/core/services/location_provider.dart"
echo "✓ Updated/created: lib/core/services/location_provider.main.dart"
echo "✓ Updated/created: lib/core/services/router_delegate.dart"
echo "✓ Updated/created: lib/core/common/views/error_page.dart"
echo ""
echo "Next steps:"
echo "1. Ensure your main.dart uses the routerDelegate from router_delegate.dart"
echo "2. Add dependency injection for your new feature's components"
echo "3. Test the new route: /${FEATURE_NAME}"
