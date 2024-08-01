const stocks = [
    { name: 'Сбер Банк', ticker: 'SBER' },
    { name: 'МТС', ticker: 'MTSS' },
    { name: 'Тинькофф групп', ticker: 'TCS' },
    { name: 'Московская биржа', ticker: 'MOEX' }
];

export function searchTicker(query) {
    const lowerQuery = query.toLowerCase();
    return stocks.filter(item => item.name.toLowerCase().includes(lowerQuery)).map(item => item.ticker);
}