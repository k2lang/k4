// K4 Programming Language - Abstract Syntax Tree Module

use std::fmt;

#[derive(Debug, Clone, PartialEq)]
pub enum Literal {
    Integer(i64),
    Float(f64),
    String(String),
    Boolean(bool),
}

#[derive(Debug, Clone, PartialEq)]
pub enum BinaryOperator {
    Add,
    Subtract,
    Multiply,
    Divide,
    Modulo,
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,
    LessThanEqual,
    GreaterThanEqual,
    And,
    Or,
}

#[derive(Debug, Clone, PartialEq)]
pub enum UnaryOperator {
    Negate,
    Not,
}

#[derive(Debug, Clone, PartialEq)]
pub enum Expression {
    Literal(Literal),
    Identifier(String),
    BinaryOperation {
        left: Box<Expression>,
        operator: BinaryOperator,
        right: Box<Expression>,
    },
    UnaryOperation {
        operator: UnaryOperator,
        operand: Box<Expression>,
    },
    FunctionCall {
        function: Box<Expression>,
        arguments: Vec<Expression>,
    },
    ArrayLiteral(Vec<Expression>),
    IndexAccess {
        array: Box<Expression>,
        index: Box<Expression>,
    },
    StructLiteral {
        name: String,
        fields: Vec<(String, Expression)>,
    },
    FieldAccess {
        object: Box<Expression>,
        field: String,
    },
    QuantumOperation {
        operation_type: String,
        qubits: Vec<Expression>,
        parameters: Vec<Expression>,
    },
    AIModel {
        model_type: String,
        parameters: Vec<Expression>,
    },
}

#[derive(Debug, Clone, PartialEq)]
pub enum Statement {
    ExpressionStatement(Expression),
    LetStatement {
        name: String,
        type_annotation: Option<String>,
        value: Option<Expression>,
    },
    ConstStatement {
        name: String,
        type_annotation: Option<String>,
        value: Expression,
    },
    ReturnStatement(Option<Expression>),
    BlockStatement(Vec<Statement>),
    IfStatement {
        condition: Expression,
        consequence: Box<Statement>,
        alternative: Option<Box<Statement>>,
    },
    WhileStatement {
        condition: Expression,
        body: Box<Statement>,
    },
    ForStatement {
        variable: String,
        iterable: Expression,
        body: Box<Statement>,
    },
    FunctionDeclaration {
        name: String,
        parameters: Vec<(String, String)>, // (name, type)
        return_type: Option<String>,
        body: Box<Statement>,
    },
    StructDeclaration {
        name: String,
        fields: Vec<(String, String)>, // (name, type)
    },
    EnumDeclaration {
        name: String,
        variants: Vec<String>,
    },
    TraitDeclaration {
        name: String,
        methods: Vec<Statement>, // Only FunctionDeclarations
    },
    ImplDeclaration {
        trait_name: Option<String>,
        type_name: String,
        methods: Vec<Statement>, // Only FunctionDeclarations
    },
    QuantumDeclaration {
        name: String,
        qubits: usize,
        operations: Vec<Statement>,
    },
    DistributedDeclaration {
        name: String,
        nodes: Vec<String>,
        body: Box<Statement>,
    },
    AIDeclaration {
        name: String,
        model_type: String,
        parameters: Vec<(String, Expression)>,
        body: Option<Box<Statement>>,
    },
}

#[derive(Debug, Clone, PartialEq)]
pub struct Program {
    pub statements: Vec<Statement>,
}

impl fmt::Display for Program {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        for statement in &self.statements {
            write!(f, "{:?}\n", statement)?;
        }
        Ok(())
    }
}