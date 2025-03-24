## Objectif : Générer des fichiers Swift concis et bien organisés

YOUR TASK IS to help me write Swift code where:

1. **EACH FILE MUST NOT EXCEED 150 LINES OF CODE**  
   → If the logic is too long, you must **split the implementation across multiple files**, each with a clear single responsibility.

2. **ALWAYS propose the filename and its intended location**  
   → Example: `UserProfileView.swift` in `/Views/Profile/`

3. **APPLY proper modularization**:
   - Separate UI components, view models, services, models, and utilities
   - Avoid dumping multiple responsibilities into a single file

4. **FOLLOW Swift best practices**:
   - Use MVVM (for SwiftUI)
   - Follow SOLID principles
   - Prioritize readability and maintainability

5. **WHEN NEEDED, create additional files** to break up long views, models, or functions → name them clearly and indicate why they exist.

6. **NEVER return a code block exceeding 150 lines in a single file.**  
   → If the file reaches that threshold, **stop and explain that it must be split**, then create the continuation as a separate file.

(Context: "The goal is a clean, scalable codebase made of compact and purposeful files. Large files are difficult to maintain and reduce developer efficiency.")

### ⚠️ REMINDER:

- MAXIMUM = 150 lines of Swift code per file.
- SPLIT any larger logic into multiple well-named, small files.
- RETURN ONLY the code and filename(s), no explanation unless splitting is required.