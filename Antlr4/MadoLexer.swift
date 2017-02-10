// Generated from Mado.g4 by ANTLR 4.6
import Antlr4

open class MadoLexer: Lexer {
	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = MadoLexer._ATN.getNumberOfDecisions()
          for i in 0..<length {
          	    decisionToDFA.append(DFA(MadoLexer._ATN.getDecisionState(i)!, i))
          }
           return decisionToDFA
     }()

	internal static let _sharedContextCache:PredictionContextCache = PredictionContextCache()
	public static let T__0=1, T__1=2, T__2=3, T__3=4, T__4=5, T__5=6, Number=7, 
                   Variable=8, WHITESPACE=9
	public static let modeNames: [String] = [
		"DEFAULT_MODE"
	]

	public static let ruleNames: [String] = [
		"T__0", "T__1", "T__2", "T__3", "T__4", "T__5", "Number", "Variable", 
		"WHITESPACE"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, "'('", "')'", "'*'", "'/'", "'+'", "'-'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, nil, nil, nil, nil, nil, nil, "Number", "Variable", "WHITESPACE"
	]
	public static let VOCABULARY: Vocabulary = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	//@Deprecated
	public let tokenNames: [String?]? = {
	    let length = _SYMBOLIC_NAMES.count
	    var tokenNames = [String?](repeating: nil, count: length)
		for i in 0..<length {
			var name = VOCABULARY.getLiteralName(i)
			if name == nil {
				name = VOCABULARY.getSymbolicName(i)
			}
			if name == nil {
				name = "<INVALID>"
			}
			tokenNames[i] = name
		}
		return tokenNames
	}()

	override
	open func getTokenNames() -> [String?]? {
		return tokenNames
	}

    open override func getVocabulary() -> Vocabulary {
        return MadoLexer.VOCABULARY
    }

	public override init(_ input: CharStream) {
	    RuntimeMetaData.checkVersion("4.6", RuntimeMetaData.VERSION)
		super.init(input)
		_interp = LexerATNSimulator(self, MadoLexer._ATN, MadoLexer._decisionToDFA, MadoLexer._sharedContextCache)
	}

	override
	open func getGrammarFileName() -> String { return "Mado.g4" }

    override
	open func getRuleNames() -> [String] { return MadoLexer.ruleNames }

	override
	open func getSerializedATN() -> String { return MadoLexer._serializedATN }

	override
	open func getModeNames() -> [String] { return MadoLexer.modeNames }

	override
	open func getATN() -> ATN { return MadoLexer._ATN }

    public static let _serializedATN: String = MadoLexerATN().jsonString
	public static let _ATN: ATN = ATNDeserializer().deserializeFromJson(_serializedATN)
}