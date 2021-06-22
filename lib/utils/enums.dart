enum TotalCases {
  Infected,
  Recovered,
  Deaths,
}

String formatTotalCasesEnum(TotalCases cases) {
  if (cases == TotalCases.Infected)
    return 'Infected';
  else if (cases == TotalCases.Recovered)
    return 'Recovered';
  else // if(cases == TotalCases.Deaths)
    return 'Deaths';
}
