// Generated from Mado.g4 by ANTLR 4.7
import Antlr4

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link MadoParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
open class MadoVisitor<T>: ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by the {@code atomVariableExpr}
	 * labeled alternative in {@link MadoParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAtomVariableExpr(_ ctx: MadoParser.AtomVariableExprContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code atomNumberExpr}
	 * labeled alternative in {@link MadoParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitAtomNumberExpr(_ ctx: MadoParser.AtomNumberExprContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code operatorExpr}
	 * labeled alternative in {@link MadoParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitOperatorExpr(_ ctx: MadoParser.OperatorExprContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code multiplyExpr}
	 * labeled alternative in {@link MadoParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitMultiplyExpr(_ ctx: MadoParser.MultiplyExprContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by the {@code parenExpr}
	 * labeled alternative in {@link MadoParser#expr}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitParenExpr(_ ctx: MadoParser.ParenExprContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link MadoParser#number}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitNumber(_ ctx: MadoParser.NumberContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

	/**
	 * Visit a parse tree produced by {@link MadoParser#variable}.
	- Parameters:
	  - ctx: the parse tree
	- returns: the visitor result
	 */
	open func visitVariable(_ ctx: MadoParser.VariableContext) -> T{
	 	fatalError(#function + " must be overridden")
	}

}