-- 1. Расчет конверсии из Заявки в Сделку по каждому менеджеру
-- Показывает эффективность отдела продаж (то, что ты считала в AIM)
SELECT 
    manager_name,
    COUNT(lead_id) AS total_leads,
    COUNT(CASE WHEN status = 'Closed_Deal' THEN 1 END) AS successful_deals,
    ROUND(COUNT(CASE WHEN status = 'Closed_Deal' THEN 1 END) * 100.0 / COUNT(lead_id), 2) AS conversion_rate
FROM crm_data
GROUP BY manager_name
ORDER BY conversion_rate DESC;

-- 2. Анализ объема продаж в денежном выражении
-- Аналог твоих отчетов по миллионам рублей и квадратным метрам
SELECT 
    project_name,
    SUM(deal_value_mln_rub) AS total_revenue,
    SUM(square_meters) AS total_sq_meters,
    AVG(price_per_meter) AS avg_meter_price
FROM deals
WHERE deal_date >= '2023-01-01'
GROUP BY project_name
ORDER BY total_revenue DESC;

-- 3. Контроль качества: средняя оценка звонков брокеров
-- То, что ты делала в Отделе контроля качества
SELECT 
    broker_name,
    AVG(call_score) AS avg_quality_score,
    COUNT(call_id) AS total_calls_audited
FROM quality_audit
GROUP BY broker_name
HAVING AVG(call_score) < 4.0; -- Выявление брокеров, которым нужно обучение
