Функция ПолучитьНастройкиИзХранилища() Экспорт 
	Настройки= итWMSПривилегированныйМодуль.ПолучитьНастройкиИзХранилища();
	Возврат Настройки;
КонецФункции

// Найти создать терминал сбора данных.
// 
// Параметры:
//  Строка-ТСДИД
// 
// Возвращаемое значение:
//  Произвольный, СправочникСсылка.итWMSСправочникТСД - Найти создать терминал сбора данных
Функция НайтиСоздатьТерминалСбораДанных(ТСДИД) Экспорт 
	ТСД=итWMSСлужебныеПроцедурыИФункции.НайтиСоздатьТерминалСбораДанных(ТСДИД);
	Возврат ТСД;
КонецФункции