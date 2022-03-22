&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Ключ.Пустая() Тогда
		ЗаполнитьШаблонДанныхОРабочихЧасах();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Заполнить(Команда)
	Если Параметры.Ключ.Пустая() Тогда
		итWMSОбщегоНазначенияКлиентСервер.СообщитьПользователю("Необходимо  записать график");
		Возврат;
	КонецЕсли;
	Оповещение=новый ОписаниеОповещения("ЗаполнитьГрафикОповещения",ЭтаФорма);
	ПоказатьВопрос(Оповещение,"Старые данные попавшие на указанный период будут перезаписаны. Продолжить?"
	,РежимДиалогаВопрос.ДаНет );
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьГрафикОповещения(Результат,Параметры) Экспорт
	Если Результат=КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СменныйГрафикПриИзменении(Элемент)

	Если Параметры.Ключ.Пустая() Тогда
		ЗаполнитьШаблонДанныхОРабочихЧасах();
		ВидимостьДоступностьЭлементов();
	Иначе
		Оповещение=новый ОписаниеОповещения("СменаГрафикаРезультат",ЭтаФорма);
		ПоказатьВопрос(Оповещение,"Задать новый шаблон табличной части?",РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
КонецПроцедуры
&НаКлиенте
Процедура СменаГрафикаРезультат(Результат,Параметры) Экспорт
	Если Результат=КодВозвратаДиалога.Да Тогда
		ЗаполнитьШаблонДанныхОРабочихЧасах();
	КонецЕсли;
	ВидимостьДоступностьЭлементов();
КонецПроцедуры


&НаСервере
Процедура ЗаполнитьШаблонДанныхОРабочихЧасах()
	Объект.ДанныеОРабочихЧасах.Очистить();
	Если Объект.СменныйГрафик Тогда
		Возврат;
	КонецЕсли;
Счетчик=1;
Пока Счетчик<=7 Цикл
	НоваяСтрока=Объект.ДанныеОРабочихЧасах.Добавить();
	НоваяСтрока.НомерДняЦикла=Счетчик;
	НоваяСтрока.ДеньНедели=ДеньНеделиСтрокой(НоваяСтрока.НомерДняЦикла);
	Счетчик=Счетчик+1;
КонецЦикла;
КонецПроцедуры
&НаСервере
Функция ДеньНеделиСтрокой(Число)
	Если Число=1 Тогда
		Возврат "Пн";
	ИначеЕсли Число=2 Тогда
		Возврат "Вт";
	ИначеЕсли Число=3 Тогда
		Возврат "Ср";
	ИначеЕсли Число=4 Тогда
		Возврат "Чт";
	ИначеЕсли Число=5 Тогда
		Возврат "Пт";
	ИначеЕсли Число=6 Тогда
		Возврат "Сб";
	Иначе
		Возврат "Вс";
	КонецЕсли;
КонецФункции
&НаКлиенте
Процедура ВидимостьДоступностьЭлементов()
	Если Объект.СменныйГрафик Тогда
		Элементы.НомерДняЦикла.Видимость=Истина;
		Элементы.ДанныеОРабочихЧасахДеньНедели.Видимость=Ложь;
	иначе
		Элементы.НомерДняЦикла.Видимость=Ложь;
		Элементы.ДанныеОРабочихЧасахДеньНедели.Видимость=Истина;
	КонецЕсли;
КонецПроцедуры

