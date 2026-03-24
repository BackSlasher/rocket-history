.PHONY: fetch-data update-index update

# Fetch data and update index
update: fetch-data update-index

# Fetch missing day files for the past 30 days
fetch-data:
	@for i in $$(seq 0 30); do \
		date=$$(date -d "today - $$i days" +%Y-%m-%d); \
		file="docs/day-$$date.json"; \
		if [ ! -f "$$file" ]; then \
			echo "Fetching $$date..."; \
			curl -sf "https://oref-map.org/api/day-history?date=$$date" -o "$$file" || rm -f "$$file"; \
		fi; \
	done

# Update DAY_FILES array in index.html based on existing files
update-index:
	@files=$$(ls docs/day-*.json 2>/dev/null | sort | sed "s|docs/||" | sed "s/\(.*\)/  '\1',/"); \
	if [ -n "$$files" ]; then \
		awk -v files="$$files" ' \
			/^const DAY_FILES = \[/ { print; in_array=1; next } \
			in_array && /^\];/ { print files; in_array=0 } \
			!in_array { print } \
		' docs/index.html > docs/index.html.tmp && mv docs/index.html.tmp docs/index.html; \
		echo "Updated DAY_FILES in index.html"; \
	fi
