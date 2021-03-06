SELECT WIP.INVESTMENT_ID,
       MONTH_BEGIN DATE_VAL,
       TO_CHAR(MONTH_BEGIN,'YYYYMM') DATE_UID,
       SUM(WIP_VALUES.AMOUNT) AMOUNT
  FROM WARM01.PPA_WIP WIP,
       WARM01.PPA_WIP_VALUES WIP_VALUES
 WHERE     WIP.TRANSNO = WIP_VALUES.TRANSNO
       -- wip values for billing
       AND WIP_VALUES.CURRENCY_TYPE = 'BILLING'
       AND WIP_VALUES.CURRENCY_CODE = 'USD'
       AND 
       -- ensure proper wip transactions
           WIP.ENTITY = 'CID'
       AND WIP.TRANSTYPE = 'L'
       AND WIP.STATUS NOT IN (2, 8)
       AND WIP.ON_HOLD = 0
GROUP BY WIP.INVESTMENT_ID,
         WIP.MONTH_BEGIN