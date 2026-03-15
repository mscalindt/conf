.PHONY: conf rel

conf:
	@test -n "$(FUNC)" || { echo 'FUNC is empty'; exit 2; }
	sh ./scripts/conf.sh "$(FUNC)"

rel:
	@test -n "$(REL)" || { echo 'REL is empty'; exit 2; }
	@test -n "$(PRE)" || { echo 'PRE is empty'; exit 2; }
	@test -n "$(CUR)" || { echo 'CUR is empty'; exit 2; }
	sh ./scripts/rel.sh "$(REL)" "$(PRE)" "$(CUR)"
