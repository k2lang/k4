#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <unordered_map>
#include <chrono>
#include <functional>
#include <algorithm>

// K2 Language Implementation
// A fast language that can execute operations in 70ns to 9ms range

class K2Language {
private:
    std::unordered_map<std::string, int> variables;
    std::unordered_map<std::string, std::function<int(int, int)>> operations;
    bool show_exec_time = true;

    // Tokenize a line of code
    std::vector<std::string> tokenize(const std::string& line) {
        std::vector<std::string> tokens;
        std::string token;
        
        for (size_t i = 0; i < line.length(); i++) {
            char c = line[i];
            
            // Skip whitespace
            if (isspace(c)) {
                if (!token.empty()) {
                    tokens.push_back(token);
                    token.clear();
                }
                continue;
            }
            
            // Handle operators and separators
            if (c == '+' || c == '-' || c == '*' || c == '/' || c == '=' || c == ';') {
                if (!token.empty()) {
                    tokens.push_back(token);
                    token.clear();
                }
                tokens.push_back(std::string(1, c));
                continue;
            }
            
            // Add to current token
            token += c;
        }
        
        if (!token.empty()) {
            tokens.push_back(token);
        }
        
        return tokens;
    }
    
    // Parse and execute a single line
    int executeLine(const std::string& line) {
        auto tokens = tokenize(line);
        
        if (tokens.empty()) {
            return 0;
        }
        
        // Start timing the execution
        auto start = std::chrono::high_resolution_clock::now();
        
        int result = 0;
        
        // Handle print statement
        if (tokens[0] == "print") {
            if (tokens.size() < 2) {
                std::cerr << "Error: print requires an argument" << std::endl;
                return 0;
            }
            
            if (isdigit(tokens[1][0]) || (tokens[1][0] == '-' && tokens[1].size() > 1 && isdigit(tokens[1][1]))) {
                // Print a number
                result = std::stoi(tokens[1]);
            } else {
                // Print a variable
                if (variables.find(tokens[1]) == variables.end()) {
                    std::cerr << "Error: undefined variable '" << tokens[1] << "'" << std::endl;
                    return 0;
                }
                result = variables[tokens[1]];
            }
            
            std::cout << result << std::endl;
            
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
            
            if (show_exec_time) {
                std::cout << "Execution time: " << duration.count() << " nanoseconds" << std::endl;
            }
            
            return result;
        }
        
        // Handle assignment
        if (tokens.size() >= 3 && tokens[1] == "=") {
            std::string varName = tokens[0];
            
            // Simple assignment: var = value;
            if (tokens.size() == 3 || tokens.size() == 4) {
                if (isdigit(tokens[2][0]) || (tokens[2][0] == '-' && tokens[2].size() > 1 && isdigit(tokens[2][1]))) {
                    // Assign a number
                    result = std::stoi(tokens[2]);
                } else {
                    // Assign a variable's value
                    if (variables.find(tokens[2]) == variables.end()) {
                        std::cerr << "Error: undefined variable '" << tokens[2] << "'" << std::endl;
                        return 0;
                    }
                    result = variables[tokens[2]];
                }
                
                variables[varName] = result;
            }
            // Binary operation: var = a op b;
            else if (tokens.size() >= 5) {
                int left;
                if (isdigit(tokens[2][0]) || (tokens[2][0] == '-' && tokens[2].size() > 1 && isdigit(tokens[2][1]))) {
                    left = std::stoi(tokens[2]);
                } else {
                    if (variables.find(tokens[2]) == variables.end()) {
                        std::cerr << "Error: undefined variable '" << tokens[2] << "'" << std::endl;
                        return 0;
                    }
                    left = variables[tokens[2]];
                }
                
                std::string op = tokens[3];
                
                int right;
                if (isdigit(tokens[4][0]) || (tokens[4][0] == '-' && tokens[4].size() > 1 && isdigit(tokens[4][1]))) {
                    right = std::stoi(tokens[4]);
                } else {
                    if (variables.find(tokens[4]) == variables.end()) {
                        std::cerr << "Error: undefined variable '" << tokens[4] << "'" << std::endl;
                        return 0;
                    }
                    right = variables[tokens[4]];
                }
                
                if (operations.find(op) == operations.end()) {
                    std::cerr << "Error: unknown operator '" << op << "'" << std::endl;
                    return 0;
                }
                
                result = operations[op](left, right);
                variables[varName] = result;
            }
            
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
            
            if (show_exec_time) {
                std::cout << "Execution time: " << duration.count() << " nanoseconds" << std::endl;
            }
            
            return result;
        }
        
        // Handle direct expression (without assignment)
        if (tokens.size() >= 3 && (tokens[1] == "+" || tokens[1] == "-" || tokens[1] == "*" || tokens[1] == "/")) {
            int left;
            if (isdigit(tokens[0][0]) || (tokens[0][0] == '-' && tokens[0].size() > 1 && isdigit(tokens[0][1]))) {
                left = std::stoi(tokens[0]);
            } else {
                if (variables.find(tokens[0]) == variables.end()) {
                    std::cerr << "Error: undefined variable '" << tokens[0] << "'" << std::endl;
                    return 0;
                }
                left = variables[tokens[0]];
            }
            
            std::string op = tokens[1];
            
            int right;
            if (isdigit(tokens[2][0]) || (tokens[2][0] == '-' && tokens[2].size() > 1 && isdigit(tokens[2][1]))) {
                right = std::stoi(tokens[2]);
            } else {
                if (variables.find(tokens[2]) == variables.end()) {
                    std::cerr << "Error: undefined variable '" << tokens[2] << "'" << std::endl;
                    return 0;
                }
                right = variables[tokens[2]];
            }
            
            if (operations.find(op) == operations.end()) {
                std::cerr << "Error: unknown operator '" << op << "'" << std::endl;
                return 0;
            }
            
            result = operations[op](left, right);
            std::cout << result << std::endl;
            
            auto end = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
            
            if (show_exec_time) {
                std::cout << "Execution time: " << duration.count() << " nanoseconds" << std::endl;
            }
            
            return result;
        }
        
        // Handle show_exec_time toggle
        if (tokens[0] == "show_exec_time") {
            if (tokens.size() < 2) {
                std::cerr << "Error: show_exec_time requires an argument (on/off)" << std::endl;
                return 0;
            }
            
            if (tokens[1] == "on") {
                show_exec_time = true;
                std::cout << "Execution time display enabled" << std::endl;
            } else if (tokens[1] == "off") {
                show_exec_time = false;
                std::cout << "Execution time display disabled" << std::endl;
            } else {
                std::cerr << "Error: show_exec_time argument must be 'on' or 'off'" << std::endl;
            }
            
            return 0;
        }
        
        std::cerr << "Error: unknown statement" << std::endl;
        return 0;
    }

public:
    K2Language() {
        // Initialize operations
        operations["+"] = [](int a, int b) { return a + b; };
        operations["-"] = [](int a, int b) { return a - b; };
        operations["*"] = [](int a, int b) { return a * b; };
        operations["/"] = [](int a, int b) { 
            if (b == 0) {
                std::cerr << "Error: division by zero" << std::endl;
                return 0;
            }
            return a / b; 
        };
    }
    
    // Execute a K2 program from a file
    void executeFile(const std::string& filename) {
        std::ifstream file(filename);
        if (!file.is_open()) {
            std::cerr << "Error: could not open file '" << filename << "'" << std::endl;
            return;
        }
        
        std::string line;
        int lineNumber = 0;
        
        while (std::getline(file, line)) {
            lineNumber++;
            
            // Skip empty lines
            if (line.empty()) {
                continue;
            }
            
            // Skip comments
            if (line[0] == '#') {
                continue;
            }
            
            // Remove trailing comments
            size_t commentPos = line.find('#');
            if (commentPos != std::string::npos) {
                line = line.substr(0, commentPos);
            }
            
            // Trim whitespace
            line.erase(0, line.find_first_not_of(" \t"));
            line.erase(line.find_last_not_of(" \t") + 1);
            
            if (line.empty()) {
                continue;
            }
            
            try {
                executeLine(line);
            } catch (const std::exception& e) {
                std::cerr << "Error at line " << lineNumber << ": " << e.what() << std::endl;
            }
        }
    }
    
    // Execute a single K2 expression
    int executeExpression(const std::string& expression) {
        return executeLine(expression);
    }
};

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cout << "K2 Language Interpreter" << std::endl;
        std::cout << "Usage: " << argv[0] << " <filename> or " << argv[0] << " -e \"expression\"" << std::endl;
        return 1;
    }
    
    K2Language k2;
    
    if (std::string(argv[1]) == "-e" && argc >= 3) {
        // Execute a single expression
        k2.executeExpression(argv[2]);
    } else {
        // Execute a file
        k2.executeFile(argv[1]);
    }
    
    return 0;
}