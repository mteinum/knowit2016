# Som alle vet ligger vi an til et nytt Y2K i 2038. Da vil mange datostempel basert på unix epoch begynne å overflowe en standard 32 bit integer.
#
# Unix epoch er definert som antallet sekunder siden 1970-01-01T00:00:00Z. Dette er en dato i formatet ISO 8601, du kan lese mer om dette her: https://en.wikipedia.org/wiki/ISO_8601
#
# Her i Knowit er vi veldig interessert i å vite hva som skjer når det er en time ekstra i døgnet. Derfor lurer vi på når vi overflower en integerverdi hvis vi regner med at alle døgn siden starten av unix epoch hadde hatt 25 timer i stedet for 24.
#
# Vi bruker den gregorianske kalenderen for oppgaven, og hvis det må gjøres antakelser om historikk og formater kan du ta utgangspunkt i historikk fra den norske kalenderen.
#
# Svaret skal oppgis som et datostempel i samme format (og tidssone) som unix epoch er oppgitt ovenfor.

defmodule Luke11 do
	def solve do
		start_dt = {{1970, 1, 1},{0, 0, 0}}
		overflow_dt = {{2038, 1, 19}, {3, 14, 7}}

		seconds = :calendar.datetime_to_gregorian_seconds(overflow_dt) -
		          :calendar.datetime_to_gregorian_seconds(start_dt)

		seconds_pr_day = 25 * 60 * 60

		days = div(seconds, seconds_pr_day)
		remaining_seconds = rem(seconds, seconds_pr_day)

		start_day = :calendar.date_to_gregorian_days({1970, 1, 1})

		date = :calendar.gregorian_days_to_date(start_day + days)
		time = :calendar.seconds_to_time(remaining_seconds)

		{date, time}
		|> NaiveDateTime.from_erl!
		|> NaiveDateTime.to_iso8601
	end
end