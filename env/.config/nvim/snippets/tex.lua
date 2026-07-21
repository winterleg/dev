---@diagnostic disable: undefined-global

return {
	s({ trig = ";list", snippetType = "autosnippet" },
		fmta([[\begin{enumerate}
	\item <>
\end{enumerate}]], { i(1) })
	),
	s({ trig = ";i", snippetType = "autosnippet" },
		fmta("\\item <>", { i(1) })
	),
	s({ trig = "mt", snippetType = "autosnippet" },
		fmta("$<>$", { i(1) })
	),
	s({ trig = "mms", snippetType = "autosnippet" },
		fmta([[\begin{align*}
	<>
\end{align*}]], { i(1) })
	),
	s({ trig = "mmt", snippetType = "autosnippet" },
		fmta([[\begin{align}
	<>
\end{align}]], { i(1) })
	),
	s({ trig = ";d", snippetType = "autosnippet" },
		fmta("\\frac{<>}{<>} <>", {
			i(1),
			i(2),
			i(3)
		})
	),
	s({ trig = "([^%s]+);f", snippetType = "autosnippet", regTrig = true },
		fmta("<>_(<>)", {
			f(function(_, s) return s.captures[1] end),
			i(1)
		})
	),
	s({ trig = "([^%s]+);t", snippetType = "autosnippet", regTrig = true },
		fmta("<>^(<>)", {
			f(function(_, s) return s.captures[1] end),
			i(1)
		})
	)
}
