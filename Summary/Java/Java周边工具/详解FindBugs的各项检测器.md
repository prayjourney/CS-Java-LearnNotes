### 详解FindBugs的各项检测器
***
FindBugs是一个静态分析工具，在程序不需运行的情况下，分析class文件，将字节码与一组缺陷模式进行对比，试图寻找真正的缺陷或者潜在的性能问题。本文档主要详细说明FindBugs 2.0.3版本中各项检测器的作用，该版本共有156个缺陷检测器，分为11个类别。

 

**1.       No Category（无类别）**

**1.1 BuildInterproceduralCallGraph**

| **模式**     | -                                                        | **速度** | 快   | **缺陷类别** | -    |
| ------------ | -------------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.BuildInterproceduralCallGraph |          |      |              |      |
| **说明**     | 构建过程之间的调用图。                                   |          |      |              |      |
| **报告模式** | 无                                                       |          |      |              |      |

 

**1.2 BuildObligationPolicyDatabase**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.BuildObligationPolicyDatabase     |          |      |              |      |
| **说明**     | 构建由FindUnsatisfiedObligation检测器使用的责任类型和方法的数据库。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.3 CalledMethods**

| **模式**     | -                                                          | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ---------------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.CalledMethods                   |          |      |              |      |
| **说明**     | 构建在被分析类中调用的所有方法的数据库，供其他检测器使用。 |          |      |              |      |
| **报告模式** | 无                                                         |          |      |              |      |

 

**1.4 CheckCalls**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.CheckCalls                        |          |      |              |      |
| **说明**     | 这个检测器仅仅在FindBugs中调试方法调用解析时使用。不要启用这个检测器。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.5 ExplicitSerialization**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.ExplicitSerialization             |          |      |              |      |
| **说明**     | 通过readObject方法和writeObject方法寻找显式的序列化操作，作为这个类确实已经序列化的证据。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.6 FieldItemSummary**

| **模式**     | -                                                  | **速度** | 快   | **缺陷类别** | -    |
| ------------ | -------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.FieldItemSummary        |          |      |              |      |
| **说明**     | 这个检测器会产生被存储为字段的所有条目的汇总信息。 |          |      |              |      |
| **报告模式** | 无                                                 |          |      |              |      |

 

**1.7 FindBugsSummaryStats**

| **模式**     | -                                               | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ----------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.FindBugsSummaryStats |          |      |              |      |
| **说明**     | 这个检测器仅仅收集分析过程相关的汇总统计信息。  |          |      |              |      |
| **报告模式** | 无                                              |          |      |              |      |

 

**1.8 FunctionThatMightBeMistakenForProcedures**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.FunctionsThatMightBeMistakenForProcedures |          |      |              |      |
| **说明**     | 有些不可变类包含了返回这个类的新实例的方法，当调用这些类实例方法时，人们偶尔会认为这些方法会修改当前的类实例，这个检测器能够找到这样的不可变类。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.9 Methods**

| **模式**     | -                                                          | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ---------------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.Methods                         |          |      |              |      |
| **说明**     | 构建在被分析类中定义的所有方法的数据库，供其他检测器使用。 |          |      |              |      |
| **报告模式** | 无                                                         |          |      |              |      |

 

**1.10 NoteAnnotationRetention**

| **模式**     | -                                                  | **速度** | 快   | **缺陷类别** | -    |
| ------------ | -------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteAnnotationRetention |          |      |              |      |
| **说明**     | 记录注解保留策略。                                 |          |      |              |      |
| **报告模式** | 无                                                 |          |      |              |      |

 

**1.11 NoteCheckReturnValueAnnotations**

| **模式**     | -                                                          | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ---------------------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteCheckReturnValueAnnotations |          |      |              |      |
| **说明**     | 寻找用于检查一个方法的返回值的注解。                       |          |      |              |      |
| **报告模式** | 无                                                         |          |      |              |      |

 

**1.12 NoteDirectlyRelevantTypeQualifiers**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteDirectlyRelevantTypeQualifiers |          |      |              |      |
| **说明**     | 记录与分析方法有关的类型修饰符。                             |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.13 NoteJCIPAnnotation**

| **模式**     | -                                             | **速度** | 快   | **缺陷类别** | -    |
| ------------ | --------------------------------------------- | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteJCIPAnnotation |          |      |              |      |
| **说明**     | 记录net.jcip.annotations包中的注解。          |          |      |              |      |
| **报告模式** | 无                                            |          |      |              |      |

 

**1.14 NoteNonNullAnnotations**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteNonNullAnnotations            |          |      |              |      |
| **说明**     | 检查方法、字段、参数是否具有@NonNull注解。当在一个应当只能使用非NULL值的上下文环境中使用了一个可能为NULL的值，那么FindNullDeref检测器会使用这些信息生成警告 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.15 NoteNonNullReturnValues**

| **模式**     | -                                                            | **速度** | 慢   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteNonnullReturnValues           |          |      |              |      |
| **说明**     | 分析应用程序中所有的方法，以便于确定哪个方法总是返回非NULL的值。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.16 NoteSuppressedWarnings**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NoteSuppressedWarnings            |          |      |              |      |
| **说明**     | 抑制基于使用edu.umd.cs.findbugs.annotations.NoteSuppressWarnings注解的警告。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.17 ReflectiveClasses**

| **模式**     | -                                                      | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.ReflectiveClasses           |          |      |              |      |
| **说明**     | 尝试确定哪些类具有指向它们自己的.class对象的常量引用。 |          |      |              |      |
| **报告模式** | 无                                                     |          |      |              |      |

 

**1.18 TestDataflowAnalysis**

| **模式**     | -                                                            | **速度** | 慢   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.TestDataflowAnalysis              |          |      |              |      |
| **说明**     | 这是一种内部检测器，只有在测试数据流分析时才会使用。默认情况下，请不要启用这个检测器。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.19 TrainFieldStoreTypes**

| **模式**     | -                                                            | **速度** | 慢   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.TrainFieldStoreTypes              |          |      |              |      |
| **说明**     | TrainFieldStoreTypes检测器会分析存储在字段中的类型，并且会将它们存储在一个数据库中。这个数据库会在稍后的分析中用到，它能够使得分析更加精确。这个检测器的速度较慢。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.20 TrainLongInstantParams**

| **模式**     | -                                                            | **速度** | 慢   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.TrainLongInstantfParams           |          |      |              |      |
| **说明**     | 构建参数数据库，这些参数的长度为64位，用于描述从标准基准时间到现在的时间长度，单位为毫秒。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.21 TrainNonNullAnnotations**

| **模式**     | -                                                            | **速度** | 快   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.TrainNonNullAnnotations           |          |      |              |      |
| **说明**     | TrainNonNullAnnotations检测器可以收集@NonNull和@PossiblyNull注解，并且可以将它们存储在数据库文件中。这个检测器的速度较快。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**1.22 TrainUnconditionalDerefParams**

| **模式**     | -                                                            | **速度** | 慢   | **缺陷类别** | -    |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.TrainUnconditionalDerefParams     |          |      |              |      |
| **说明**     | TrainUnconditionalParamDerefs检测器可以确定哪些方法可以无条件解引用参数，并且可以将它们存储在一个文件中。生成的文件可以在后续的检测中使用，它可以改善NULL解引用检测器的精确度。因为这只是一连串检测中的一个环节，所以不会报告任何警告。这个检测器的速度较慢。 |          |      |              |      |
| **报告模式** | 无                                                           |          |      |              |      |

 

**2.       Bad Practice（坏习惯）**

**2.1 BooleanReturnNull**

| **模式**     | NP                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.BooleanReturnNull                 |          |      |              |        |
| **说明**     | 检查是否有返回类型为Boolean，但是却显式返回了NULL值的方法。  |          |      |              |        |
| **报告模式** | 1.      NP_BOOLEAN_RETURN_NULL  (NP, BAD_PRACTICE):  Boolean返回类型的方法显式返回了NULL值。 |          |      |              |        |

 

**2.2CheckImmutableAnnotation**

| **模式**     | JCIP                                                         | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.CheckImmutableAnnotation          |          |      |              |        |
| **说明**     | 检查被注解为net.jcip.annotations.Immutable或javax.annotation.concurrent.Immutable的类是否违反规则。 |          |      |              |        |
| **报告模式** | 1.      JCIP_FIELD_ISNT_FINAL_IN_IMMUTABLE_CLASS  (JCIP, BAD_PRACTICE):  不可变类的字段应当是final的 |          |      |              |        |

 

**2.3 CloneIdiom**

| **模式**     | CN                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.CloneIdiom                        |          |      |              |        |
| **说明**     | 这个检测器会检查编写的可克隆类是否违反惯用语法。             |          |      |              |        |
| **报告模式** | 1.      CN_IDIOM  (CN, BAD_PRACTICE):  类实现了Cloneable接口，但是没有定义或使用clone方法2.      CN_IDIOM_NO_SUPER_CALL  (CN, BAD_PRACTICE):  clone方法没有调用super.clone()方法3.      CN_IMPLEMENTS_CLONE_BUT_NOT_CLONEABLE  (CN, BAD_PRACTICE):  类定义了clone()方法，但是没有实现Cloneable接口 |          |      |              |        |

 

**2.4 ComparatorIdiom**

| **模式**     | Se                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.ComparatorIdiom                   |          |      |              |        |
| **说明**     | 这个检测器会检查编写的实现Comparator接口的类是否违反惯用语法。 |          |      |              |        |
| **报告模式** | 1.      SE_COMPARATOR_SHOULD_BE_SERIALIZABLE  (Se, BAD_PRACTICE):  比较器类没有实现Serializable接口 |          |      |              |        |

 

**2.5 DontCatchIllegalMonitorStateException**

| **模式**     | IMSE                                                         | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DontCatchIllegalMonitorStateException |          |      |              |        |
| **说明**     | 这个检测器会检查try-catch代码块是否捕捉IllegalMonitorStateException异常。 |          |      |              |        |
| **报告模式** | 1.      IMSE_DONT_CATCH_IMSE  (IMSE, BAD_PRACTICE):  可疑的IllegalMonitorStateException异常捕捉 |          |      |              |        |

 

**2.6 DontUseEnum**

| **模式**     | Nm                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DontUseEnum                       |          |      |              |        |
| **说明**     | 检查字段和方法的名称是否是assert或enum，因为它们是Java 5的关键字。 |          |      |              |        |
| **报告模式** | 1.                  NM_FUTURE_KEYWORD_USED_AS_IDENTIFIER  (Nm, BAD_PRACTICE):  使用的标识符是Java后续版本中的一个关键字2.                  NM_FUTURE_KEYWORD_USED_AS_MEMBER_IDENTIFIER  (Nm, BAD_PRACTICE):  使用的标识符是Java后续版本中的一个关键字 |          |      |              |        |

 

**2.7 DroppedException**

| **模式**     | DE                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DroppedException                  |          |      |              |        |
| **说明**     | 这个检测器会找出代码中捕捉异常，但是却没有对异常进行任何处理的地方。 |          |      |              |        |
| **报告模式** | 1.      DE_MIGHT_DROP  (DE, BAD_PRACTICE):  方法可能遗漏异常处理2.      DE_MIGHT_IGNORE  (DE, BAD_PRACTICE):  方法可能忽略异常处理 |          |      |              |        |

 

**2.8 EmptyZipFileEntry**

| **模式**     | AM                                                           | **速度** | 中   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.EmptyZipFileEntry                 |          |      |              |        |
| **说明**     | 这个检测器会检查是否创建了空白的zip文件项。这个检测器的运行速度中等。 |          |      |              |        |
| **报告模式** | 1.      AM_CREATES_EMPTY_JAR_FILE_ENTRY  (AM, BAD_PRACTICE):  创建的jar文件项为空2.      AM_CREATES_EMPTY_ZIP_FILE_ENTRY  (AM, BAD_PRACTICE):  创建的zip文件项为空 |          |      |              |        |

 

**2.9 EqualsOperandShouldHaveClassCompatibleWithThis**

| **模式**     | Eq                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.EqualsOperandShouldHaveClassCompatibleWithThis |          |      |              |        |
| **说明**     | 检查equals方法，该方法的操作数是一个和定义这个equals方法的类不兼容的类的实例。 |          |      |              |        |
| **报告模式** | 1.      EQ_CHECK_FOR_OPERAND_NOT_COMPATIBLE_WITH_THIS  (Eq, BAD_PRACTICE):  检查equals方法的操作数是否兼容 |          |      |              |        |

 

**2.10 FinalizerNullFields**

| **模式**     | FI                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FinalizerNullsFields              |          |      |              |        |
| **说明**     | 这个检测器会找到将类的字段设置为NULL值的finalize()方法。无论如何，这个检测器都不会帮助到垃圾收集器，将字段设置为NULL值不会产生任何影响。 |          |      |              |        |
| **报告模式** | 1.      FI_FINALIZER_NULLS_FIELDS  (FI, BAD_PRACTICE):  finalize()方法将字段设置为NULL值2.      FI_FINALIZER_ONLY_NULLS_FIELDS  (FI, BAD_PRACTICE):  finalize()方法仅将字段设置为NULL值 |          |      |              |        |

 

**2.11 FindNonSerializableStoreIntoSession**

| **模式**     | J2EE                                                         | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindNonSerializableStoreIntoSession |          |      |              |        |
| **说明**     | 这个检测器会检查是否将不可序列化的对象（没有实现Serializable接口的类实例）存储至HTTP会话中。 |          |      |              |        |
| **报告模式** | 1.      J2EE_STORE_OF_NON_SERIALIZABLE_OBJECT_INTO_SESSION  (J2EE, BAD_PRACTICE):  将不可序列化对象存储至HttpSession |          |      |              |        |

 

**2.12 FindOpenStream**

| **模式**     | ODR\|OS                                                      | **速度** | 慢   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindOpenStream                    |          |      |              |        |
| **说明**     | 这个检测器会找出退出方法时没有及时关闭的I/O流对象。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      ODR_OPEN_DATABASE_RESOURCE  (ODR, BAD_PRACTICE):  方法未能成功关闭数据库资源2.      ODR_OPEN_DATABASE_RESOURCE_EXCEPTION_PATH  (ODR, BAD_PRACTICE):  异常发生时，方法未能成功关闭数据库资源3.      OS_OPEN_STREAM  (OS, BAD_PRACTICE):  方法未能成功关闭流4.      OS_OPEN_STREAM_EXCEPTION_PATH  (OS, BAD_PRACTICE):  异常发生时，方法未能成功关闭流 |          |      |              |        |

 

**2.13 InheritanceUnsafeGetResource**

| **模式**     | UI                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InheritanceUnsafeGetResource      |          |      |              |        |
| **说明**     | 检查this.getClass().getResource(...)方法的使用状况，如果当前类被另一个包中的类扩展时，调用这个方法可能会产生无法预料的结果。 |          |      |              |        |
| **报告模式** | 1.      UI_INHERITANCE_UNSAFE_GETRESOURCE  (UI, BAD_PRACTICE):  如果扩展这个类，那么使用getResource方法可能是不安全的 |          |      |              |        |

 

**2.14 InstantiateStaticClass**

| **模式**     | ISC                                                          | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InstantiateStaticClass            |          |      |              |        |
| **说明**     | 这个检测器会检查是否创建了静态类的对象，静态类就是只定义静态方法的类。 |          |      |              |        |
| **报告模式** | 1.      ISC_INSTANTIATE_STATIC_CLASS  (ISC, BAD_PRACTICE):  不需要实例化只提供静态方法的类 |          |      |              |        |

 

**2.15 IteratorIdioms**

| **模式**     | It                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.IteratorIdioms                    |          |      |              |        |
| **说明**     | 这个迭代器会检查是否正确定义Iterator类。                     |          |      |              |        |
| **报告模式** | 1.      IT_NO_SUCH_ELEMENT  (It, BAD_PRACTICE):  迭代器的next()方法不能抛出NoSuchElementException异常 |          |      |              |        |

 

**2.16 ReadReturnShouldBeChecked**

| **模式**     | RR                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.ReadReturnShouldBeChecked         |          |      |              |        |
| **说明**     | 这个检测器会检查代码中忽略返回值的地方是否调用了InputStream.read()方法或InputStream.skip()方法。 |          |      |              |        |
| **报告模式** | 1.      RR_NOT_CHECKED  (RR, BAD_PRACTICE):  方法忽略InputStream.read()的结果2.      SR_NOT_CHECKED  (RR, BAD_PRACTICE):  方法忽略InputStream.skip()的结果 |          |      |              |        |

 

**2.17 FindRefComparison**

| **模式**     | DMI\|EC\|ES\|RC                                              | **速度** | 慢   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindRefComparison                 |          |      |              |        |
| **说明**     | 这个检测器会找出代码中使用==或!=运算符比较两个引用值是否相等的地方，因为这种比较对象引用（例如java.lang.String的对象引用）的方式通常会产生错误。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      DMI_DOH  (DMI, CORRECTNESS):  一个无意义的方法调用2.      EC_ARRAY_AND_NONARRAY  (EC, CORRECTNESS):  使用equals()方法比较数组类型和非数组类型3.      EC_BAD_ARRAY_COMPARE  (EC, CORRECTNESS):  对一个数组调用equals()方法，等价于使用==运算符4.      EC_INCOMPATIBLE_ARRAY_COMPARE  (EC, CORRECTNESS):  使用equals(...)方法比较不兼容的数组5.      EC_NULL_ARG  (EC, CORRECTNESS):  调用equals(null)方法6.      EC_UNRELATED_CLASS_AND_INTERFACE  (EC, CORRECTNESS):  调用equals()方法比较不相关的类和接口7.      EC_UNRELATED_INTERFACES  (EC, CORRECTNESS):  调用equals()方法比较不同的接口类型8.      EC_UNRELATED_TYPES  (EC, CORRECTNESS):  调用equals()方法比较不同的类型9.      EC_UNRELATED_TYPES_USING_POINTER_EQUALITY  (EC, CORRECTNESS):  使用指针等式比较不同的类型10.  ES_COMPARING_PARAMETER_STRING_WITH_EQ  (ES, BAD_PRACTICE):  使用==或!=运算符比较String参数11.  ES_COMPARING_STRINGS_WITH_EQ  (ES, BAD_PRACTICE):  使用==或!=运算符比较String对象12.  RC_REF_COMPARISON  (RC, CORRECTNESS):  可疑的引用比较13.  RC_REF_COMPARISON_BAD_PRACTICE  (RC, BAD_PRACTICE):  可疑的常量引用比较14.  RC_REF_COMPARISON_BAD_PRACTICE_BOOLEAN  (RC, BAD_PRACTICE):  可疑的Boolean值引用比较 |          |      |              |        |

 

**2.18 FindUnrelatedTypesInGenericContainer**

| **模式**     | DMI\|GC                                                      | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUnrelatedTypesInGenericContainer |          |      |              |        |
| **说明**     | 当调用形参为java.lang.Object类型的范型集合方法时，这个检测器会检查使用的实参是否与集合形参相关。不要将不相关类型的实参放在集合中。例如，如果foo是List<String>类型的，bar是StringBuffer类型的，那么调用foo.contains(bar)方法只会返回false。这个检测器运行速度较快。 |          |      |              |        |
| **报告模式** | 1.      DMI_COLLECTIONS_SHOULD_NOT_CONTAIN_THEMSELVES  (DMI, CORRECTNESS):  集合不应当包含它们2.      DMI_USING_REMOVEALL_TO_CLEAR_COLLECTION  (DMI, BAD_PRACTICE):  不要使用removeAll方法清空一个集合3.      DMI_VACUOUS_SELF_COLLECTION_CALL  (DMI, CORRECTNESS):  对集合的空调用4.      GC_UNCHECKED_TYPE_IN_GENERIC_CALL  (GC, BAD_PRACTICE):  范型调用中的未选择类型5.      GC_UNRELATED_TYPES  (GC, CORRECTNESS):  范型形参和方法实参之间没有关联 |          |      |              |        |

 

**2.19 IncompatMask**

| **模式**     | BIT                                                          | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.IncompatMask                      |          |      |              |        |
| **说明**     | 这个检测器会检查可疑的位逻辑运算表达式。                     |          |      |              |        |
| **报告模式** | 1.      BIT_AND  (BIT, CORRECTNESS):  不兼容的位掩码2.      BIT_AND_ZZ  (BIT, CORRECTNESS):  检查代码中是否有表达式((...) & 0) == 03.      BIT_IOR  (BIT, CORRECTNESS):  不兼容的位掩码4.      BIT_SIGNED_CHECK  (BIT, BAD_PRACTICE):  检查代码中是否有带符号的位运算5.      BIT_SIGNED_CHECK_HIGH_BIT  (BIT, CORRECTNESS):  检查代码中是否有带符号的位运算 |          |      |              |        |

 

**2.20 Naming**

| **模式**     | Nm                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.Naming                            |          |      |              |        |
| **说明**     | 这个检测器会寻找代码中是否有可疑的方法命名。                 |          |      |              |        |
| **报告模式** | 1.      NM_BAD_EQUAL  (Nm, CORRECTNESS):  类定义了equal(Object)方法，它应当是equals(Object)吗?2.      NM_CLASS_NAMING_CONVENTION  (Nm, BAD_PRACTICE):  类名应当以大写字母开头3.      NM_CLASS_NOT_EXCEPTION  (Nm, BAD_PRACTICE):  类没有派生于Exception类，虽然它的名字很像异常4.      NM_CONFUSING  (Nm, BAD_PRACTICE):  令人困惑的方法名称5.      NM_FIELD_NAMING_CONVENTION  (Nm, BAD_PRACTICE):  字段名应当以小写字母开头6.      NM_LCASE_HASHCODE  (Nm, CORRECTNESS):  类定义了hashcode()方法，它应当是hashcode()吗?7.      NM_LCASE_TOSTRING  (Nm, CORRECTNESS):  类定义了toString()方法，它应当是toString()吗?8.      NM_METHOD_CONSTRUCTOR_CONFUSION  (Nm, CORRECTNESS):  明显的方法/构造器混淆9.      NM_METHOD_NAMING_CONVENTION  (Nm, BAD_PRACTICE):  方法名应当以小写字母开头10.  NM_SAME_SIMPLE_NAME_AS_INTERFACE  (Nm, BAD_PRACTICE):  类名不应当屏蔽已实现接口的简单名11.  NM_SAME_SIMPLE_NAME_AS_SUPERCLASS  (Nm, BAD_PRACTICE):  类名不应当屏蔽父类的简单名12.  NM_VERY_CONFUSING  (Nm, CORRECTNESS):  非常令人困惑的方法名13.  NM_VERY_CONFUSING_INTENTIONAL  (Nm, BAD_PRACTICE):  非常令人困惑的方法名（但可能是有意的）14.  NM_WRONG_PACKAGE  (Nm, CORRECTNESS):  由于错误的参数封装，方法没有覆盖父类中的方法15.  NM_WRONG_PACKAGE_INTENTIONAL  (Nm, BAD_PRACTICE):  由于错误的参数封装，方法没有覆盖父类中的方法（但可能是有意的） |          |      |              |        |

 

**2.21 FindHEmismatch**

| **模式**     | Co\|Eq\|HE                                                   | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindHEmismatch                    |          |      |              |        |
| **说明**     | 这个检测器会检查代码中的hashCode()和equals()方法的定义是否有问题。 |          |      |              |        |
| **报告模式** | 1.      CO_ABSTRACT_SELF  (Co, BAD_PRACTICE):  抽象类定义了共变的compareTo()方法2.      CO_SELF_NO_OBJECT  (Co, BAD_PRACTICE):  定义了共变compareTo()方法3.      EQ_ABSTRACT_SELF  (Eq, BAD_PRACTICE):  抽象类定义了共变的compareTo()方法4.      EQ_COMPARETO_USE_OBJECT_EQUALS  (Eq, BAD_PRACTICE):  类定义了compareTo(...)方法，使用了Object.equals()方法5.      EQ_DOESNT_OVERRIDE_EQUALS  (Eq, STYLE):  类没有覆盖父类中的equals方法6.      EQ_DONT_DEFINE_EQUALS_FOR_ENUM  (Eq, CORRECTNESS):  为枚举类型定义了共变equals()方法7.      EQ_OTHER_NO_OBJECT  (Eq, CORRECTNESS):  定义的equals()方法没有覆盖equals(Object)方法8.      EQ_OTHER_USE_OBJECT  (Eq, CORRECTNESS):  定义的equals()方法没有覆盖Object.equals(Object)方法9.      EQ_SELF_NO_OBJECT  (Eq, BAD_PRACTICE):  定义了共变equals()方法10.  EQ_SELF_USE_OBJECT  (Eq, CORRECTNESS):  定义了共变equals()方法，继承于Object.equals(Object)方法11.  HE_EQUALS_NO_HASHCODE  (HE, BAD_PRACTICE):  类定义了equals()方法，但是没有定义hashCode()方法12.  HE_EQUALS_USE_HASHCODE  (HE, BAD_PRACTICE):  类定义了equals()方法，并且使用Object.hashCode()方法13.  HE_HASHCODE_NO_EQUALS  (HE, BAD_PRACTICE):  类定义了hashCode()方法，但是没有定义equals()方法14.  HE_HASHCODE_USE_OBJECT_EQUALS  (HE, BAD_PRACTICE):  类定义了hashCode()方法，并且使用Object.equals()方法15.  HE_INHERITS_EQUALS_USE_HASHCODE  (HE, BAD_PRACTICE):  类继承了equals()方法，并且使用Object.hashCode()方法16.  HE_SIGNATURE_DECLARES_HASHING_OF_UNHASHABLE_CLASS  (HE, CORRECTNESS):  签名声明在哈希结构中使用不可哈希化的类17.  HE_USE_OF_UNHASHABLE_CLASS  (HE, CORRECTNESS):  在一个哈希数据结构中使用没有hashCode()方法的类 |          |      |              |        |

 

**2.22 FindNullDeref**

| **模式**     | NP\|RCN                                                      | **速度** | 慢   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindNullDeref                     |          |      |              |        |
| **说明**     | 这个检测器会找出代码中可能发生空指针异常的地方。它还会找出对空引用值的多余的比较。这个检测器运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      NP_ALWAYS_NULL  (NP, CORRECTNESS):  空指针解引用2.      NP_ALWAYS_NULL_EXCEPTION  (NP, CORRECTNESS):  方法中的异常路径上的空指针解引用3.      NP_ARGUMENT_MIGHT_BE_NULL  (NP, CORRECTNESS):  方法没有检查NULL实参4.      NP_CLONE_COULD_RETURN_NULL  (NP, BAD_PRACTICE):  clone方法可能返回NULL5.      NP_CLOSING_NULL  (NP, CORRECTNESS):  调用一个总是NULL的值的close()方法6.      NP_DEREFERENCE_OF_READLINE_VALUE  (NP, STYLE):  没有进行判空检查就对readLine()方法的结果解引用7.      NP_EQUALS_SHOULD_HANDLE_NULL_ARGUMENT  (NP, BAD_PRACTICE):  equals()方法没有检查NULL实参8.      NP_GUARANTEED_DEREF  (NP, CORRECTNESS):  NULL值肯定会被解引用9.      NP_GUARANTEED_DEREF_ON_EXCEPTION_PATH  (NP, CORRECTNESS):  异常路径上的NULL值肯定会被解引用10.  NP_NONNULL_PARAM_VIOLATION  (NP, CORRECTNESS):  调用方法时，将NULL传递给一个非NULL形参11.  NP_NONNULL_RETURN_VIOLATION  (NP, CORRECTNESS):  方法可能返回NULL，但是声明为@NonNull12.  NP_NULL_ON_SOME_PATH  (NP, CORRECTNESS):  可能的空指针解引用13.  NP_NULL_ON_SOME_PATH_EXCEPTION  (NP, CORRECTNESS):  方法中的异常路径上的可能的空指针解引用14.  NP_NULL_ON_SOME_PATH_FROM_RETURN_VALUE  (NP, STYLE):  由于被调用方法的返回值可能为空，所以可能会有空指针解引用15.  NP_NULL_ON_SOME_PATH_MIGHT_BE_INFEASIBLE  (NP, STYLE):  可能是不可达分支路径上的可能的空指针解引用16.  NP_NULL_PARAM_DEREF  (NP, CORRECTNESS):  调用方法时，将NULL传递给一个非NULL形参17.  NP_NULL_PARAM_DEREF_ALL_TARGETS_DANGEROUS  (NP, CORRECTNESS):  调用方法时，将NULL传递给一个非NULL形参18.  NP_NULL_PARAM_DEREF_NONVIRTUAL  (NP, CORRECTNESS):  调用非虚方法时，将NULL传递给一个非NULL形参19.  NP_STORE_INTO_NONNULL_FIELD  (NP, CORRECTNESS):  将NULL值存储在被声明为@NonNull的字段中20.  NP_TOSTRING_COULD_RETURN_NULL  (NP, BAD_PRACTICE):  toString方法可能返回NULL21.  RCN_REDUNDANT_COMPARISON_OF_NULL_AND_NONNULL_VALUE  (RCN, STYLE):  非NULL值和NULL值之间的多余比较22.  RCN_REDUNDANT_COMPARISON_TWO_NULL_VALUES  (RCN, STYLE):  两个NULL值之间的多余比较23.  RCN_REDUNDANT_NULLCHECK_OF_NONNULL_VALUE  (RCN, STYLE):  对已知非NULL的值进行多余的判空检查24.  RCN_REDUNDANT_NULLCHECK_OF_NULL_VALUE  (RCN, STYLE):  对已知NULL的值进行多余的判空检查25.  RCN_REDUNDANT_NULLCHECK_WOULD_HAVE_BEEN_A_NPE  (RCN, CORRECTNESS):  对前面已经解引用的值进行多余的判空检查 |          |      |              |        |

 

**2.23 FormatStringChecker**

| **模式**     | FS\|USELESS_STRING                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FormatStringChecker               |          |      |              |        |
| **说明**     | 检查不正确的格式化字符串。                                   |          |      |              |        |
| **报告模式** | 1.      VA_FORMAT_STRING_BAD_ARGUMENT  (FS, CORRECTNESS):  格式化字符串的占位符与传递的实参不兼容2.      VA_FORMAT_STRING_BAD_CONVERSION  (FS, CORRECTNESS):  提供实参的类型与格式指定符不匹配3.      VA_FORMAT_STRING_BAD_CONVERSION_FROM_ARRAY  (USELESS_STRING, CORRECTNESS):  使用格式化字符串无效地格式化数组4.      VA_FORMAT_STRING_BAD_CONVERSION_TO_BOOLEAN  (FS, STYLE):  使用“%b”格式指定符格式化非Boolean类型的实参5.      VA_FORMAT_STRING_EXPECTED_MESSAGE_FORMAT_SUPPLIED  (FS, CORRECTNESS):  在可预料的风格格式之处提供消息格式6.      VA_FORMAT_STRING_EXTRA_ARGUMENTS_PASSED  (FS, CORRECTNESS):  传递的实参个数多于在格式化字符串中实际使用的个数7.      VA_FORMAT_STRING_ILLEGAL  (FS, CORRECTNESS):  非法的格式化字符串8.      VA_FORMAT_STRING_MISSING_ARGUMENT  (FS, CORRECTNESS):  格式化字符串引用缺少实参9.      VA_FORMAT_STRING_NO_PREVIOUS_ARGUMENT  (FS, CORRECTNESS):  没有前面的格式化字符串参数10.  VA_FORMAT_STRING_USES_NEWLINE  (FS, BAD_PRACTICE):  格式化字符串应当使用“%n”，而不是“\n” |          |      |              |        |

 

**2.24 MethodReturnCheck**

| **模式**     | RV                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.MethodReturnCheck                 |          |      |              |        |
| **说明**     | 这个检测器会找出代码中调用带有返回值的方法，但是可疑地忽略掉方法返回值的地方。 |          |      |              |        |
| **报告模式** | 1.      RV_CHECK_COMPARETO_FOR_SPECIFIC_RETURN_VALUE  (RV, CORRECTNESS):  代码检查compareTo方法返回的特定值2.      RV_EXCEPTION_NOT_THROWN  (RV, CORRECTNESS):  创建并丢弃异常，而不是抛出异常3.      RV_RETURN_VALUE_IGNORED  (RV, CORRECTNESS):  方法忽略返回值4.      RV_RETURN_VALUE_IGNORED_BAD_PRACTICE  (RV, BAD_PRACTICE):  方法忽略异常的返回值5.      RV_RETURN_VALUE_IGNORED_INFERRED  (RV, STYLE):  方法忽略返回值，这样可以么？ |          |      |              |        |

 

**2.25 OverridingEqualsNotSymmetrical**

| **模式**     | Eq                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.OverridingEqualsNotSymmetrical    |          |      |              |        |
| **说明**     | 检查代码中覆盖一个父类equals方法的equals方法，找出其中等值关系可能不是对称的。 |          |      |              |        |
| **报告模式** | 1.      EQ_ALWAYS_FALSE  (Eq, CORRECTNESS):  equals方法总是返回false2.      EQ_ALWAYS_TRUE  (Eq, CORRECTNESS):  equals方法总是返回true3.      EQ_COMPARING_CLASS_NAMES  (Eq, CORRECTNESS):  equals方法比较类的名称，而不是类的对象4.      EQ_GETCLASS_AND_CLASS_CONSTANT  (Eq, BAD_PRACTICE):  equals方法未能成功比较子类型5.      EQ_OVERRIDING_EQUALS_NOT_SYMMETRIC  (Eq, CORRECTNESS):  equals方法覆盖父类的equals方法，可能不是对称的6.      EQ_UNUSUAL  (Eq, STYLE):  不正常的equals方法 |          |      |              |        |

 

**2.26 DumbMethods**

| **模式**     | BC\|BIT\|Dm\|DMI\|Bx\|INT\|NP\|RV\|SW                        | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DumbMethods                       |          |      |              |        |
| **说明**     | 这个检测器会找到代码中调用无意义方法的地方，例如调用无参数的String构造器。 |          |      |              |        |
| **报告模式** | 1.      BC_EQUALS_METHOD_SHOULD_WORK_FOR_ALL_OBJECTS  (BC, BAD_PRACTICE):  equals方法不应当假定它的参数类型2.      BIT_ADD_OF_SIGNED_BYTE  (BIT, CORRECTNESS):  对有符号的字节值进行按位加的运算3.      BIT_IOR_OF_SIGNED_BYTE  (BIT, CORRECTNESS):  对有符号的字节值进行按位或的运算4.      DMI_ANNOTATION_IS_NOT_VISIBLE_TO_REFLECTION  (Dm, CORRECTNESS):  没有使用运行时保留时，不能使用反射机制检查注解是否存在5.      DMI_ARGUMENTS_WRONG_ORDER  (DMI, CORRECTNESS):  反向方法参数6.      DMI_BIGDECIMAL_CONSTRUCTED_FROM_DOUBLE  (DMI, CORRECTNESS):  使用没有精确表示的double值构建BigDecimal对象7.      DMI_CALLING_NEXT_FROM_HASNEXT  (DMI, CORRECTNESS):  hasNext方法调用next方法8.      DMI_COLLECTION_OF_URLS  (Dm, PERFORMANCE):  URL使用Map/Set集合可能会造成性能堵塞9.      DMI_DOH  (DMI, CORRECTNESS):  一个无意义的方法调用10.  DMI_FUTILE_ATTEMPT_TO_CHANGE_MAXPOOL_SIZE_OF_SCHEDULED_THREAD_POOL_EXECUTOR  (Dm, CORRECTNESS):  尝试修改ScheduledThreadPoolExecutor池的最大尺寸是无效的11.  DMI_LONG_BITS_TO_DOUBLE_INVOKED_ON_INT  (DMI, CORRECTNESS):  对一个int值调用Double.longBitsToDouble方法12.  DMI_RANDOM_USED_ONLY_ONCE  (DMI, BAD_PRACTICE):  创建Random对象，并且只使用一次13.  DMI_SCHEDULED_THREAD_POOL_EXECUTOR_WITH_ZERO_CORE_THREADS  (Dm, CORRECTNESS):  创建没有核心线程的ScheduledThreadPoolExecutor14.  DMI_THREAD_PASSED_WHERE_RUNNABLE_EXPECTED  (Dm, STYLE):  预期传入Runnable的地方却传入Thread15.  DMI_VACUOUS_CALL_TO_EASYMOCK_METHOD  (Dm, CORRECTNESS):  EasyMock方法的无用/空调用16.  DM_BOOLEAN_CTOR  (Dm, PERFORMANCE):  方法调用低效的Boolean构造器，应当使用Boolean.valueOf(...)方法替代17.  DM_BOXED_PRIMITIVE_FOR_PARSING  (Bx, PERFORMANCE):  使用封装/反封装来解析一个基本类型18.  DM_BOXED_PRIMITIVE_TOSTRING  (Bx, PERFORMANCE):  方法仅仅为了调用toString方法而分配一个已封装基本类型19.  DM_CONVERT_CASE  (Dm, I18N):  考虑使用调用方法参数化版本的Locale20.  DM_EXIT  (Dm, BAD_PRACTICE):  方法调用System.exit(...)21.  DM_GC  (Dm, PERFORMANCE):  显式的垃圾收集：极度可疑的代码，除非是性能测试代码22.  DM_MONITOR_WAIT_ON_CONDITION  (Dm, MT_CORRECTNESS):  监控按条件调用的wait()方法23.  DM_NEW_FOR_GETCLASS  (Dm, PERFORMANCE):  方法分配一个对象，仅仅为了获得类对象24.  DM_NEXTINT_VIA_NEXTDOUBLE  (Dm, PERFORMANCE):  为了生成一个随机整数，调用Random对象的nextInt方法，而不是nextDouble方法25.  DM_RUN_FINALIZERS_ON_EXIT  (Dm, BAD_PRACTICE):  方法调用危险的runFinalizersOnExit方法26.  DM_STRING_CTOR  (Dm, PERFORMANCE):  方法调用低效的new String(String)构造器27.  DM_STRING_TOSTRING  (Dm, PERFORMANCE):  方法对一个String对象调用toString()方法28.  DM_STRING_VOID_CTOR  (Dm, PERFORMANCE):  方法调用低效的new String()构造器29.  DM_USELESS_THREAD  (Dm, MT_CORRECTNESS):  使用默认为空的run方法创建一个线程30.  INT_BAD_COMPARISON_WITH_INT_VALUE  (INT, CORRECTNESS):  比较int值和long常量的错误比较方法31.  INT_BAD_COMPARISON_WITH_NONNEGATIVE_VALUE  (INT, CORRECTNESS):  比较非负值和负值常量的错误比较方法32.  INT_BAD_COMPARISON_WITH_SIGNED_BYTE  (INT, CORRECTNESS):  带符号字节值的错误比较方法33.  INT_BAD_REM_BY_1  (INT, STYLE):  整数余数模134.  INT_VACUOUS_BIT_OPERATION  (INT, STYLE):  对整数值进行空的位掩码运算35.  INT_VACUOUS_COMPARISON  (INT, STYLE):  对整数值进行空的比较运算36.  NP_IMMEDIATE_DEREFERENCE_OF_READLINE  (NP, STYLE):  对readLine()方法的结果立即解引用37.  RV_01_TO_INT  (RV, CORRECTNESS):  0和1之间的随机值被强制转换为整数038.  RV_ABSOLUTE_VALUE_OF_HASHCODE  (RV, CORRECTNESS):  计算带符号32位散列码绝对值的错误尝试39.  RV_ABSOLUTE_VALUE_OF_RANDOM_INT  (RV, CORRECTNESS):  计算带符号随机整数绝对值的错误尝试40.  RV_REM_OF_HASHCODE  (RV, STYLE):  散列码的余数可能是负数41.  RV_REM_OF_RANDOM_INT  (RV, STYLE):  32位带符号随机整数的余数42.  SW_SWING_METHODS_INVOKED_IN_SWING_THREAD  (SW, BAD_PRACTICE):  某些swing方法需要在Swing线程中调用 |          |      |              |        |

 

**2.27 SerializableIdiom**

| **模式**     | RS\|Se\|SnVI\|WS                                             | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SerializableIdiom                 |          |      |              |        |
| **说明**     | 这个检测器会检查Serializable类实现中的潜在问题。             |          |      |              |        |
| **报告模式** | 1.      RS_READOBJECT_SYNC  (RS, MT_CORRECTNESS):  类的readObject()方法是同步的2.      SE_BAD_FIELD  (Se, BAD_PRACTICE):  可序列化类中的非暂态不可序列化的实例字段3.      SE_BAD_FIELD_INNER_CLASS  (Se, BAD_PRACTICE):  不可序列化的类有一个可序列化的内部类4.      SE_BAD_FIELD_STORE  (Se, BAD_PRACTICE):  不可序列化的值存储在一个可序列化类的实例字段中5.      SE_INNER_CLASS  (Se, BAD_PRACTICE):  可序列化的内部类6.      SE_METHOD_MUST_BE_PRIVATE  (Se, CORRECTNESS):  为了能够成功序列化，方法必须是私有的7.      SE_NONFINAL_SERIALVERSIONID  (Se, BAD_PRACTICE):  serialVersionUID不是final的8.      SE_NONLONG_SERIALVERSIONID  (Se, BAD_PRACTICE):  serialVersionUID不是long型的9.      SE_NONSTATIC_SERIALVERSIONID  (Se, BAD_PRACTICE):  serialVersionUID不是静态的10.  SE_NO_SERIALVERSIONID  (SnVI, BAD_PRACTICE):  类实现了Serializable接口，但是没有定义serialVersionUID11.  SE_NO_SUITABLE_CONSTRUCTOR  (Se, BAD_PRACTICE):  类实现了Serializable接口，但是它的父类没有定义一个空构造器12.  SE_NO_SUITABLE_CONSTRUCTOR_FOR_EXTERNALIZATION  (Se, BAD_PRACTICE):  类实现了Externalizable接口，但是没有定义一个空构造器13.  SE_PRIVATE_READ_RESOLVE_NOT_INHERITED  (Se, STYLE):  私有的readResolve方法不会被子类继承14.  SE_READ_RESOLVE_IS_STATIC  (Se, CORRECTNESS):  readResolve方法不能声明为static方法15.  SE_READ_RESOLVE_MUST_RETURN_OBJECT  (Se, BAD_PRACTICE):  readResolve方法必须声明为返回Object类型16.  SE_TRANSIENT_FIELD_NOT_RESTORED  (Se, BAD_PRACTICE):  反序列化没有设置transient字段17.  SE_TRANSIENT_FIELD_OF_NONSERIALIZABLE_CLASS  (Se, STYLE):  类的transient字段不可序列化18.  WS_WRITEOBJECT_SYNC  (WS, MT_CORRECTNESS):  类的writeObject()方法是同步的，但是没有做其他事情 |          |      |              |        |

 

**2.28 FindPuzzlers**

| **模式**     | Bx\|Co\|DLS\|DMI\|USELESS_STRING\|EC\|BSHIFT\|ICAST\|IC\|IJU\|IM\|PZ\|RV | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindPuzzlers                      |          |      |              |        |
| **说明**     | 这个检测器会检查Joshua Bloch和Neal Gafter在他们的著作《Programming Puzzlers》中提到的各种小错误。 |          |      |              |        |
| **报告模式** | 1.      BX_BOXING_IMMEDIATELY_UNBOXED  (Bx, PERFORMANCE):  封装基本类型的值，然后又立即反封装2.      BX_BOXING_IMMEDIATELY_UNBOXED_TO_PERFORM_COERCION  (Bx, PERFORMANCE):  封装了基本类型的值，然后为了进行基本类型的强制转换，又再次反封装3.      BX_UNBOXED_AND_COERCED_FOR_TERNARY_OPERATOR  (Bx, CORRECTNESS):  反封装基本类型的值，然后强制用于三元运算符4.      BX_UNBOXING_IMMEDIATELY_REBOXED  (Bx, PERFORMANCE):  反封装已经封装的值，然后又立即重新封装5.      CO_COMPARETO_RESULTS_MIN_VALUE  (Co, CORRECTNESS):  compareTo()/compare()方法返回Integer.MIN_VALUE6.      DLS_DEAD_LOCAL_STORE_IN_RETURN  (DLS, STYLE):  返回语句中的无效赋值操作7.      DLS_OVERWRITTEN_INCREMENT  (DLS, CORRECTNESS):  覆盖增量方法8.      DMI_BAD_MONTH  (DMI, CORRECTNESS):  表示月份的错误常量值9.      DMI_ENTRY_SETS_MAY_REUSE_ENTRY_OBJECTS  (DMI, BAD_PRACTICE):  由于重用Entry对象，向一个Entry集合添加元素可能会失败10.  DMI_INVOKING_HASHCODE_ON_ARRAY  (DMI, CORRECTNESS):  对一个数组调用hashCode方法11.  DMI_INVOKING_TOSTRING_ON_ANONYMOUS_ARRAY  (USELESS_STRING, CORRECTNESS):  对一个未命名数组调用toString方法12.  DMI_INVOKING_TOSTRING_ON_ARRAY  (USELESS_STRING, CORRECTNESS):  对一个数组调用toString方法13.  EC_BAD_ARRAY_COMPARE  (EC, CORRECTNESS):  对一个数组调用equals()方法等价于使用==运算符14.  ICAST_BAD_SHIFT_AMOUNT  (BSHIFT, CORRECTNESS):  32位int型值的移位量不在-31和31之间15.  ICAST_INTEGER_MULTIPLY_CAST_TO_LONG  (ICAST, STYLE):  将整数乘法运算的结果转换为long型16.  ICAST_QUESTIONABLE_UNSIGNED_RIGHT_SHIFT  (BSHIFT, STYLE):  将无符号右移运算的结果转换为short/byte型17.  IC_SUPERCLASS_USES_SUBCLASS_DURING_INITIALIZATION  (IC, BAD_PRACTICE):  父类在初始化期间使用了子类18.  IJU_ASSERT_METHOD_INVOKED_FROM_RUN_METHOD  (IJU, CORRECTNESS):  run方法中的JUnit断言将不会被JUnit注意到19.  IM_AVERAGE_COMPUTATION_COULD_OVERFLOW  (IM, STYLE):  均值计算可能会溢出20.  IM_BAD_CHECK_FOR_ODD  (IM, STYLE):  不能对负数进行奇偶判断21.  IM_MULTIPLYING_RESULT_OF_IREM  (IM, CORRECTNESS):  一个整数和一次整数取余运算的结果相乘22.  PZ_DONT_REUSE_ENTRY_OBJECTS_IN_ITERATORS  (PZ, BAD_PRACTICE):  没有在迭代器中重用条目对象23.  RV_NEGATING_RESULT_OF_COMPARETO  (RV, BAD_PRACTICE):  对compareTo()/compare()方法的结果进行取反运算 |          |      |              |        |

 

**2.29 FindUseOfNonSerializableValue**

| **模式**     | DMI\|J2EE                                                    | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUseOfNonSerializableValue     |          |      |              |        |
| **说明**     | 这个检测器会检查在需要使用可序列化对象的上下文中是否使用了不可序列化的对象。 |          |      |              |        |
| **报告模式** | 1.      DMI_NONSERIALIZABLE_OBJECT_WRITTEN  (DMI, STYLE):  将不可序列化对象写入ObjectOutput2.      J2EE_STORE_OF_NON_SERIALIZABLE_OBJECT_INTO_SESSION  (J2EE, BAD_PRACTICE):  将不可序列化对象存至HttpSession |          |      |              |        |

 

**2.30 InitializationChain**

| **模式**     | IC\|SI                                                       | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InitializationChain               |          |      |              |        |
| **说明**     | 这个检测器会找出潜在的环状类初始化依赖关系。                 |          |      |              |        |
| **报告模式** | 1.      IC_INIT_CIRCULARITY  (IC, STYLE):  环状初始化2.      SI_INSTANCE_BEFORE_FINALS_ASSIGNED  (SI, BAD_PRACTICE):  静态初始化程序在所有static final字段被赋值之前创建实例 |          |      |              |        |

 

**2.31 NoteUnconditionalParamDerefs**

| **模式**     | NP                                                           | **速度** | 慢   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.NoteUnconditionalParamDerefs      |          |      |              |        |
| **说明**     | 分析应用程序中的所有方法，以便于确定哪些解引用参数是无条件的。这些信息会在稍后的分析中用到，用来找出代码中调用方法，但可能将空值传给这些方法的地方。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      NP_EQUALS_SHOULD_HANDLE_NULL_ARGUMENT  (NP, BAD_PRACTICE):  equals()方法没有检查参数是否为null2.      NP_PARAMETER_MUST_BE_NONNULL_BUT_MARKED_AS_NULLABLE  (NP, STYLE):  参数不能为空值，但是却标记为可为空值 |          |      |              |        |

 

**2.32 FindFinalizeInvocations**

| **模式**     | FI                                                           | **速度** | 快   | **缺陷类别** | 坏习惯 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindFinalizeInvocations           |          |      |              |        |
| **说明**     | 这个检测器会找到代码中调用finalize()的地方，以及其他和finalize()方法相关的问题。 |          |      |              |        |
| **报告模式** | 1.      FI_EMPTY  (FI, BAD_PRACTICE):  应当删除空的finalize()方法2.      FI_EXPLICIT_INVOCATION  (FI, BAD_PRACTICE):  显式调用finalize()方法3.      FI_MISSING_SUPER_CALL  (FI, BAD_PRACTICE):  finalize()方法没有调用父类的finalize()方法4.      FI_NULLIFY_SUPER  (FI, BAD_PRACTICE):  finalize()方法使父类的finalize()方法无效5.      FI_PUBLIC_SHOULD_BE_PROTECTED  (FI, MALICIOUS_CODE):  finalize()方法应当是protected的，不是public的6.      FI_USELESS  (FI, BAD_PRACTICE):  除了调用父类的finalize()之外，finalize()方法什么都没做 |          |      |              |        |

 

**3.       Correctness（正确性）**

**3.1 AppendingToAnObjectOutputStream**

| **模式**     | IO                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.AppendingToAnObjectOutputStream   |          |      |              |        |
| **说明**     | 找出代码中试图向一个对象输出流添加信息的地方。               |          |      |              |        |
| **报告模式** | 1.      IO_APPENDING_TO_OBJECT_OUTPUT_STREAM  (IO, CORRECTNESS):  试图向一个对象输出流添加信息 |          |      |              |        |

 

**3.2 BadAppletConstructor**

| **模式**     | BAC                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.BadAppletConstructor              |          |      |              |        |
| **说明**     | 某些applet的构造器会调用父类applet中的方法，而父类applet可能依赖于applet存根，这个检测器会找出这些applet构造器。因为这个存根直到调用init()方法时才会初始化，所以构造器中调用的这些方法将会失败。 |          |      |              |        |
| **报告模式** | 1.      BAC_BAD_APPLET_CONSTRUCTOR  (BAC, CORRECTNESS):  依赖于未初始化AppletStub的错误applet构造器 |          |      |              |        |

 

**3.3 BadResultSetAccess**

| **模式**     | SQL                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.BadResultSetAccess                |          |      |              |        |
| **说明**     | 这个检测器会检查一个结果集的getXXX或setXXX方法，找出字段索引值为0的上述方法调用。因为ResultSet字段的起始索引为1，所以前述的方法调用总是错误的。 |          |      |              |        |
| **报告模式** | 1.      SQL_BAD_PREPARED_STATEMENT_ACCESS  (SQL, CORRECTNESS):  方法试图通过0索引访问一个预处理语句参数2.      SQL_BAD_RESULTSET_ACCESS  (SQL, CORRECTNESS):  方法试图通过0索引访问一个结果集字段 |          |      |              |        |

 

**3.4 BadSyntaxForRegularExpression**

| **模式**     | RE                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.BadSyntaxForRegularExpression     |          |      |              |        |
| **说明**     | 这个检测器会找出含有无效语法的正则表达式。                   |          |      |              |        |
| **报告模式** | 1.      RE_BAD_SYNTAX_FOR_REGULAR_EXPRESSION  (RE, CORRECTNESS):  正则表达式使用无效语法2.      RE_CANT_USE_FILE_SEPARATOR_AS_REGULAR_EXPRESSION  (RE, CORRECTNESS):  正则表达式使用文件分隔符3.      RE_POSSIBLE_UNINTENDED_PATTERN  (RE, CORRECTNESS):  正则表达式使用“.”或“\|”符号 |          |      |              |        |

 

**3.5 BadlyOverriddenAdapter**

| **模式**     | BOA                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.BadlyOverriddenAdapter            |          |      |              |        |
| **说明**     | 某些类会扩展Adapter类，并且会使用错误的签名覆盖一个Listener方法，这个检测器会找出这些类的代码。 |          |      |              |        |
| **报告模式** | 1.      BOA_BADLY_OVERRIDDEN_ADAPTER  (BOA, CORRECTNESS):  类错误地覆盖父类Adapter中实现的一个方法 |          |      |              |        |

 

**3.6 CheckExpectedWarnings**

| **模式**     | FB                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.CheckExpectedWarnings             |          |      |              |        |
| **说明**     | 检查@ExpectedWarning和@NoWarning注解。这个检测器仅仅用于测试FindBugs。 |          |      |              |        |
| **报告模式** | 1.      FB_MISSING_EXPECTED_WARNING  (FB, CORRECTNESS):  FindBugs没有发出预期的或期望的警告2.      FB_UNEXPECTED_WARNING  (FB, CORRECTNESS):  FindBugs发出预期外或非期望的警告 |          |      |              |        |

 

**3.7 FindFloatMath**

| **模式**     | FL                                                           | **速度** | 中   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindFloatMath                     |          |      |              |        |
| **说明**     | 这个检测器会找出代码中使用浮点运算的地方。这个检测器的运行速度中等。 |          |      |              |        |
| **报告模式** | 1.      FL_MATH_USING_FLOAT_PRECISION  (FL, CORRECTNESS):  方法执行具有浮点精度的运算 |          |      |              |        |

 

**3.8 FindMaskedFields**

| **模式**     | MF                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindMaskedFields                  |          |      |              |        |
| **说明**     | 这个检测器会检查类的属性字段是否被方法中定义的局部变量遮蔽。 |          |      |              |        |
| **报告模式** | 1.      MF_CLASS_MASKS_FIELD  (MF, CORRECTNESS):  类定义的字段遮蔽了一个父类的字段2.      MF_METHOD_MASKS_FIELD  (MF, CORRECTNESS):  方法定义一个隐藏类字段的局部变量 |          |      |              |        |

 

**3.9 FindNullDerefsInvolvlingNonShortCircuitEvaluation**

| **模式**     | NP                                                           | **速度** | 慢   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindNullDerefsInvolvingNonShortCircuitEvaluation |          |      |              |        |
| **说明**     | 这个检测器会找到代码中可能发生空指针异常的地方，使用非短路求值会导致不能成功使用常用技巧。 |          |      |              |        |
| **报告模式** | 1.      NP_GUARANTEED_DEREF  (NP, CORRECTNESS):  一定会对null值解引用2.      NP_NULL_ON_SOME_PATH  (NP, CORRECTNESS):  可能的空指针解引用 |          |      |              |        |

 

**3.10 FindSelfComparison2**

| **模式**     | SA                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindSelfComparison2               |          |      |              |        |
| **说明**     | 这个检测器会找出代码中一个值和它自己进行比较的地方。         |          |      |              |        |
| **报告模式** | 1.      SA_FIELD_SELF_COMPARISON  (SA, CORRECTNESS):  字段与它自己比较2.      SA_FIELD_SELF_COMPUTATION  (SA, CORRECTNESS):  对一个字段进行无意义的自我计算（例如x & x）3.      SA_LOCAL_SELF_COMPARISON  (SA, CORRECTNESS):  局部变量与它自己比较4.      SA_LOCAL_SELF_COMPUTATION  (SA, CORRECTNESS):  对一个局部变量进行无意义的自我计算（例如x & x） |          |      |              |        |

 

**3.11 FindUninitializedGet**

| **模式**     | UR                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUninitializedGet              |          |      |              |        |
| **说明**     | 这个检测器会检查构造器中是否读取未初始化的字段。             |          |      |              |        |
| **报告模式** | 1.      UR_UNINIT_READ  (UR, CORRECTNESS):  构造器中读取未初始化字段 |          |      |              |        |

 

**3.12 InfiniteLoop**

| **模式**     | IL                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InfiniteLoop                      |          |      |              |        |
| **说明**     | 检查代码中是否有无限循环                                     |          |      |              |        |
| **报告模式** | 1.      IL_INFINITE_LOOP  (IL, CORRECTNESS):  一个明显的无限循环 |          |      |              |        |

 

**3.13 InfiniteRecursiveLoop**

| **模式**     | IL                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InfiniteRecursiveLoop             |          |      |              |        |
| **说明**     | 检查代码中是否有无限的递归循环。                             |          |      |              |        |
| **报告模式** | 1.      IL_CONTAINER_ADDED_TO_ITSELF  (IL, CORRECTNESS):  一个自我添加的集合2.      IL_INFINITE_RECURSIVE_LOOP  (IL, CORRECTNESS):  一个明显的无限递归循环 |          |      |              |        |

 

**3.14 InitializeNonnullFieldsInConstructor**

| **模式**     | NP                                                           | **速度** | 中   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InitializeNonnullFieldsInConstructor |          |      |              |        |
| **说明**     | 找到没有在构造器中写入的非空字段。                           |          |      |              |        |
| **报告模式** | 1.      NP_NONNULL_FIELD_NOT_INITIALIZED_IN_CONSTRUCTOR  (NP, CORRECTNESS):  没有初始化非空字段 |          |      |              |        |

 

**3.15 IntCast2LongAsInstant**

| **模式**     | ICAST                                                        | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.IntCast2LongAsInstant             |          |      |              |        |
| **说明**     | 找出代码中使用32位值描述从标准基准时间到现在的时间长度（以毫秒为单位）的地方。 |          |      |              |        |
| **报告模式** | 1.      ICAST_INT_2_LONG_AS_INSTANT  (ICAST, CORRECTNESS):  将int型值转换为long型，用于表示绝对时间 |          |      |              |        |

 

**3.16 InvalidJUnitTest**

| **模式**     | IJU                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.InvalidJUnitTest                  |          |      |              |        |
| **说明**     | 这个检测器会找出有缺陷的JUnit测试代码。                      |          |      |              |        |
| **报告模式** | 1.      IJU_BAD_SUITE_METHOD  (IJU, CORRECTNESS):  TestCase声明一个错误的suite方法2.      IJU_NO_TESTS  (IJU, CORRECTNESS):  TestCase中没有测试3.      IJU_SETUP_NO_SUPER  (IJU, CORRECTNESS):  TestCase定义的setUp方法没有调用super.setUp()方法4.      IJU_SUITE_NOT_STATIC  (IJU, CORRECTNESS):  TestCase实现一个非静态suite方法5.      IJU_TEARDOWN_NO_SUPER  (IJU, CORRECTNESS):  TestCase定义的tearDown方法没有调用super.tearDown()方法 |          |      |              |        |

 

**3.17 QuestionableBooleanAssignment**

| **模式**     | QBA                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.QuestionableBooleanAssignment     |          |      |              |        |
| **说明**     | 这个检测器会找出代码中将布尔字面值简单的赋值给变量的条件表达式。 |          |      |              |        |
| **报告模式** | 1.      QBA_QUESTIONABLE_BOOLEAN_ASSIGNMENT  (QBA, CORRECTNESS):  方法在布尔表达式中赋值布尔字面值 |          |      |              |        |

 

**3.18 ReadOfInstanceFieldInMethodInvokedByConstructorInSuperclass**

| **模式**     | UR                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.ReadOfInstanceFieldInMethodInvokedByConstructorInSuperclass |          |      |              |        |
| **说明**     | 检查父类构造器中调用的方法是否正确。                         |          |      |              |        |
| **报告模式** | 1.      UR_UNINIT_READ_CALLED_FROM_SUPER_CONSTRUCTOR  (UR, CORRECTNESS):  父类构造器调用未初始化的字段读取方法 |          |      |              |        |

 

**3.19 RepeatedConditionals**

| **模式**     | RpC                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.RepeatedConditionals              |          |      |              |        |
| **说明**     | 这个检测器会找出代码中包含重复条件测试的地方，例如(x == 5 \|\| x == 5)。 |          |      |              |        |
| **报告模式** | 1.      RpC_REPEATED_CONDITIONAL_TEST  (RpC, CORRECTNESS):  重复条件测试 |          |      |              |        |

 

**3.20 ResolveAllReferencece**

| **模式**     | VR                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.ResolveAllReferences              |          |      |              |        |
| **说明**     | 检查代码中所有的引用调用是否已解析。                         |          |      |              |        |
| **报告模式** | 1.      VR_UNRESOLVABLE_REFERENCE  (VR, CORRECTNESS):  类引用未能识别的类或方法 |          |      |              |        |

 

**3.21 SuperfluousInstanceOf**

| **模式**     | SIO                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SuperfluousInstanceOf             |          |      |              |        |
| **说明**     | 这个检测器会找出代码中本该静态确定类型，但却使用instanceof运算符进行类型检查的地方。 |          |      |              |        |
| **报告模式** | 1.      SIO_SUPERFLUOUS_INSTANCEOF  (SIO, CORRECTNESS):  使用instanceof运算符进行不必要的类型检查 |          |      |              |        |

 

**3.22 SuspiciousThreadInterrupted**

| **模式**     | STI                                                          | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SuspiciousThreadInterrupted       |          |      |              |        |
| **说明**     | 这个检测器会找出从一个非静态上下文中调用的Thread.interrupted()方法。如果调用的是Thread.currentThread().interrupted()方法，那么这会是一次无效的操作，只要使用Thread.interrupted()即可。然而，如果是对一个任意的线程对象调用这个方法，那么非常有可能发生错误，因为总是对当前线程调用interrupted()方法。 |          |      |              |        |
| **报告模式** | 1.      STI_INTERRUPTED_ON_CURRENTTHREAD  (STI, CORRECTNESS):  不需要调用currentThread()方法，直接调用interrupted()方法即可2.      STI_INTERRUPTED_ON_UNKNOWNTHREAD  (STI, CORRECTNESS):  对线程实例调用静态的Thread.interrupted()方法 |          |      |              |        |

 

**3.23 UncallableMethodOfAnonymousClass**

| **模式**     | UMAC                                                         | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.UncallableMethodOfAnonymousClass  |          |      |              |        |
| **说明**     | 这个检测器会检查具有方法定义的匿名内部类，找出那些包含想要覆盖但又没有覆盖父类方法的方法的匿名内部类。 |          |      |              |        |
| **报告模式** | 1.      UMAC_UNCALLABLE_METHOD_OF_ANONYMOUS_CLASS  (UMAC, CORRECTNESS):  匿名类含有无法调用的方法定义 |          |      |              |        |

 

**3.24 VarArgsProblems**

| **模式**     | VA                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.VarArgsProblems                   |          |      |              |        |
| **说明**     | 找出由Java 1.5的可变参数引起的问题。                         |          |      |              |        |
| **报告模式** | 1.      VA_PRIMITIVE_ARRAY_PASSED_TO_OBJECT_VARARG  (VA, CORRECTNESS):  将基本类型数组传递给预期接收可变数量对象实参的方法 |          |      |              |        |

 

**3.25 CheckTypeQualifiers**

| **模式**     | TQ                                                           | **速度** | 慢   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.CheckTypeQualifiers               |          |      |              |        |
| **说明**     | 检查变量是否违反由JSR-305类型的修饰符注解所指定的属性。      |          |      |              |        |
| **报告模式** | 1.      TQ_ALWAYS_VALUE_USED_WHERE_NEVER_REQUIRED  (TQ, CORRECTNESS):  变量在不能带有一个类型修饰符的地方却带有这个类型修饰符2.      TQ_COMPARING_VALUES_WITH_INCOMPATIBLE_TYPE_QUALIFIERS  (TQ, CORRECTNESS):  比较不兼容的类型修饰符所修饰的变量3.      TQ_EXPLICIT_UNKNOWN_SOURCE_VALUE_REACHES_ALWAYS_SINK  (TQ, STYLE):  将需要带有类型修饰符的变量标记为未知4.      TQ_EXPLICIT_UNKNOWN_SOURCE_VALUE_REACHES_NEVER_SINK  (TQ, STYLE):  将不需要带有类型修饰符的变量标记为未知5.      TQ_MAYBE_SOURCE_VALUE_REACHES_ALWAYS_SINK  (TQ, CORRECTNESS):  变量可能不带有一个类型修饰符，但使用时却总是需要它带有这个类型修饰符6.      TQ_MAYBE_SOURCE_VALUE_REACHES_NEVER_SINK  (TQ, CORRECTNESS):  变量可能带有一个类型修饰符，但使用时却禁止它带有这个类型修饰符7.      TQ_NEVER_VALUE_USED_WHERE_ALWAYS_REQUIRED  (TQ, CORRECTNESS):  在需要变量带有一个类型修饰符的地方，却将这个变量注解为从不带有这个类型修饰符8.      TQ_UNKNOWN_VALUE_USED_WHERE_ALWAYS_STRICTLY_REQUIRED  (TQ, CORRECTNESS):  变量在需要带有类型修饰符的地方却没有带有这个类型修饰符 |          |      |              |        |

 

**3.26 FindBadCast2**

| **模式**     | BC\|NP                                                       | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindBadCast2                      |          |      |              |        |
| **说明**     | 这个检测器会通过数据流分析找出错误的对象引用转换。           |          |      |              |        |
| **报告模式** | 1.      BC_BAD_CAST_TO_ABSTRACT_COLLECTION  (BC, STYLE):  可疑的抽象集合类型转换2.      BC_BAD_CAST_TO_CONCRETE_COLLECTION  (BC, STYLE):  可疑的实体集合类型转换3.      BC_IMPOSSIBLE_CAST  (BC, CORRECTNESS):  不可能的转换4.      BC_IMPOSSIBLE_DOWNCAST  (BC, CORRECTNESS):  不可能的向下转换5.      BC_IMPOSSIBLE_DOWNCAST_OF_TOARRAY  (BC, CORRECTNESS):  不可能的toArray()结果向下转换6.      BC_IMPOSSIBLE_INSTANCEOF  (BC, CORRECTNESS):  instanceof总是会返回false7.      BC_UNCONFIRMED_CAST  (BC, STYLE):  未检查/未确认的类型转换8.      BC_UNCONFIRMED_CAST_OF_RETURN_VALUE  (BC, STYLE):  未检查/未确认的方法返回值类型转换9.      BC_VACUOUS_INSTANCEOF  (BC, STYLE):  instanceof总是会返回true10.  NP_NULL_INSTANCEOF  (NP, CORRECTNESS):  检查一个已知的空值是哪种类型的实例 |          |      |              |        |

 

**3.27 FindDeadLocalStores**

| **模式**     | DLS\|IP                                                      | **速度** | 中   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindDeadLocalStores               |          |      |              |        |
| **说明**     | 这个检测器会找出赋值之后从来没有使用过的局部向量。这个检测器的运行速度中等。 |          |      |              |        |
| **报告模式** | 1.      DLS_DEAD_LOCAL_INCREMENT_IN_RETURN  (DLS, CORRECTNESS):  返回语句中的无用增量2.      DLS_DEAD_LOCAL_STORE  (DLS, STYLE):  死存储局部向量3.      DLS_DEAD_LOCAL_STORE_OF_NULL  (DLS, STYLE):  空值死存储局部向量4.      DLS_DEAD_LOCAL_STORE_SHADOWS_FIELD  (DLS, STYLE):  遮蔽字段的死存储局部向量5.      DLS_DEAD_STORE_OF_CLASS_LITERAL  (DLS, CORRECTNESS):  死存储类常量6.      IP_PARAMETER_IS_DEAD_BUT_OVERWRITTEN  (IP, CORRECTNESS):  没有读取传入方法的参数，但是覆写了这个参数 |          |      |              |        |

 

**3.28 FindFiledSelfAssignment**

| **模式**     | SA                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindFieldSelfAssignment           |          |      |              |        |
| **说明**     | 这个检测器会找出代码中通过读取一个字段的值来为同一个字段赋值的地方。 |          |      |              |        |
| **报告模式** | 1.      SA_FIELD_SELF_ASSIGNMENT  (SA, CORRECTNESS):  自我赋值的字段2.      SA_LOCAL_DOUBLE_ASSIGNMENT  (SA, STYLE):  双重赋值的局部变量 |          |      |              |        |

 

**3.29 FindFloatEquality**

| **模式**     | FE                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindFloatEquality                 |          |      |              |        |
| **说明**     | 找出代码中的浮点数判等表达式。这个检测器的运行速度较快。     |          |      |              |        |
| **报告模式** | 1.      FE_FLOATING_POINT_EQUALITY  (FE, STYLE):  浮点数的相等性测试2.      FE_TEST_IF_EQUAL_TO_NOT_A_NUMBER  (FE, CORRECTNESS):  注定失败的NaN相等性测试 |          |      |              |        |

 

**3.30 FindLocalSelfAssignment2**

| **模式**     | SA                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindLocalSelfAssignment2          |          |      |              |        |
| **说明**     | 这个检测器会找出代码中自我赋值的局部变量。                   |          |      |              |        |
| **报告模式** | 1.      SA_LOCAL_SELF_ASSIGNMENT  (SA, STYLE):  局部变量自我赋值2.      SA_LOCAL_SELF_ASSIGNMENT_INSTEAD_OF_FIELD  (SA, CORRECTNESS):  局部变量自我赋值，而不是赋值给字段 |          |      |              |        |

 

**3.31 FindSelfComparison**

| **模式**     | SA                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindSelfComparison                |          |      |              |        |
| **说明**     | 这个检测器会找出代码中取值进行自我比较的地方。               |          |      |              |        |
| **报告模式** | 1.      SA_FIELD_DOUBLE_ASSIGNMENT  (SA, STYLE):  字段双重赋值2.      SA_FIELD_SELF_COMPARISON  (SA, CORRECTNESS):  字段自我比较3.      SA_FIELD_SELF_COMPUTATION  (SA, CORRECTNESS):  字段无意义的自我计算（例如x & x）4.      SA_LOCAL_SELF_COMPARISON  (SA, CORRECTNESS):  取值自我比较5.      SA_LOCAL_SELF_COMPUTATION  (SA, CORRECTNESS):  变量无意义的自我计算（例如x & x） |          |      |              |        |

 

**3.32 IDivResultCastToDouble**

| **模式**     | ICAST                                                        | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.IdivResultCastToDouble            |          |      |              |        |
| **说明**     | 这个检测器会找出代码中将整数除法的结果转换为double型的地方。通常，有意义的操作应当是将int型操作数转换为double型，然后再执行除法运算。 |          |      |              |        |
| **报告模式** | 1.      ICAST_IDIV_CAST_TO_DOUBLE  (ICAST, STYLE):  将整数除法的结果转换为double或float型2.      ICAST_INT_CAST_TO_DOUBLE_PASSED_TO_CEIL  (ICAST, CORRECTNESS):  将整数值转换为double类型，然后传给Math.ceil方法3.      ICAST_INT_CAST_TO_FLOAT_PASSED_TO_ROUND  (ICAST, CORRECTNESS):  将int型值转换为float型，然后传给Math.round方法 |          |      |              |        |

 

**3.33 witchFallThrough**

| **模式**     | SF                                                           | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SwitchFallthrough                 |          |      |              |        |
| **说明**     | 这个检测器会找出存在跨越分支问题的switch语句。               |          |      |              |        |
| **报告模式** | 1.      SF_DEAD_STORE_DUE_TO_SWITCH_FALLTHROUGH  (SF, CORRECTNESS):  由于switch语句跨越分支引起的死存储2.      SF_DEAD_STORE_DUE_TO_SWITCH_FALLTHROUGH_TO_THROW  (SF, CORRECTNESS):  由于switch语句跨越分支抛出异常引起的死存储3.      SF_SWITCH_FALLTHROUGH  (SF, STYLE):  发现switch语句中的一个case分支跨越到下一个case分支中4.      SF_SWITCH_NO_DEFAULT  (SF, STYLE):  发现switch语句缺少默认的case分支 |          |      |              |        |

 

**3.34 UnreadFields**

| **模式**     | NP\|SIC\|SS\|ST\|UrF\|UuF\|UwF                               | **速度** | 快   | **缺陷类别** | 正确性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.UnreadFields                      |          |      |              |        |
| **说明**     | 这个检测器会找出代码中从未被读取过值的字段。                 |          |      |              |        |
| **报告模式** | 1.      NP_UNWRITTEN_FIELD  (NP, CORRECTNESS):  读取没有写入过的字段2.      NP_UNWRITTEN_PUBLIC_OR_PROTECTED_FIELD  (NP, STYLE):  读取没有写入过的public或protected字段3.      SIC_INNER_SHOULD_BE_STATIC  (SIC, PERFORMANCE):  应当是一个静态内部类4.      SIC_INNER_SHOULD_BE_STATIC_ANON  (SIC, PERFORMANCE):  可以重构为一个具名静态内部类5.      SIC_INNER_SHOULD_BE_STATIC_NEEDS_THIS  (SIC, PERFORMANCE):  可以重构为一个静态内部类6.      SIC_THREADLOCAL_DEADLY_EMBRACE  (SIC, CORRECTNESS):  非静态内部类和本地线程产生死锁7.      SS_SHOULD_BE_STATIC  (SS, PERFORMANCE):  未读字段：这个字段应当是静态的吗？8.      ST_WRITE_TO_STATIC_FROM_INSTANCE_METHOD  (ST, STYLE):  在实例方法中写入静态字段9.      URF_UNREAD_FIELD  (UrF, PERFORMANCE):  未读字段10.  URF_UNREAD_PUBLIC_OR_PROTECTED_FIELD  (UrF, STYLE):  未读public/protected字段11.  UUF_UNUSED_FIELD  (UuF, PERFORMANCE):  未使用字段12.  UUF_UNUSED_PUBLIC_OR_PROTECTED_FIELD  (UuF, STYLE):  未使用public/protected字段13.  UWF_FIELD_NOT_INITIALIZED_IN_CONSTRUCTOR  (UwF, STYLE):  在构造器中没有初始化字段，稍后也没有进行判空操作就解引用这个字段14.  UWF_NULL_FIELD  (UwF, CORRECTNESS):  字段一直被设为空15.  UWF_UNWRITTEN_FIELD  (UwF, CORRECTNESS):  未写入字段16.  UWF_UNWRITTEN_PUBLIC_OR_PROTECTED_FIELD  (UwF, STYLE):  未写入public/protected字段 |          |      |              |        |

 

**4.       Dodgy Code（危险代码）**

**4.1 BadUseOfReturnValue**

| **模式**     | RV                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.BadUseOfReturnValue               |          |      |              |          |
| **说明**     | 找出代码中在确定函数的返回值为非空之后，就直接将其丢弃不使用的地方。 |          |      |              |          |
| **报告模式** | 1.      RV_CHECK_FOR_POSITIVE_INDEXOF  (RV, STYLE):  方法检查String.indexOf方法的结果是否是正数2.      RV_DONT_JUST_NULL_CHECK_READLINE  (RV, STYLE):  方法检查readLine的结果是非空值之后，直接丢弃这个结果 |          |      |              |          |

 

**4.2 CallToUnsupportedMethod**

| **模式**     | Dm                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.CallToUnsupportedMethod           |          |      |              |          |
| **说明**     | 这个检测器会找出代码中调用不支持方法的地方。                 |          |      |              |          |
| **报告模式** | 1.      DMI_UNSUPPORTED_METHOD  (Dm, STYLE):  调用不支持的方法 |          |      |              |          |

 

**4.3 CheckRelaxingNullnessAnnotation**

| **模式**     | NP                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.CheckRelaxingNullnessAnnotation   |          |      |              |          |
| **说明**     | 检查覆盖方法是否对返回值放宽@Nonnull的限制或者对参数放宽@CheckForNull的限制。 |          |      |              |          |
| **报告模式** | 1.      NP_METHOD_PARAMETER_TIGHTENS_ANNOTATION  (NP, STYLE):  方法对参数收紧空值性注解2.      NP_METHOD_RETURN_RELAXING_ANNOTATION  (NP, STYLE):  方法对返回值放宽空值性注解 |          |      |              |          |

 

**4.4 ConfusedInheritance**

| **模式**     | CI                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.ConfusedInheritance               |          |      |              |          |
| **说明**     | 这个检测器会找出声明了受保护（protected）成员的final类。因为final类是不能被继承的，所以对其成员使用受保护访问是不正确的。应当将访问方法修改为公开的（public）或私有的（private），以此表示这个字段的正确含义。这是由于改变了这个类的用途而导致的，没有完全将所有的类改变为新的范型。 |          |      |              |          |
| **报告模式** | 1.      CI_CONFUSED_INHERITANCE  (CI, STYLE):  声明受保护字段的final类 |          |      |              |          |

 

**4.5 ConfusionBetweenInheritedAndOuterMethod**

| **模式**     | IA                                                           | **速度** | 中   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.ConfusionBetweenInheritedAndOuterMethod |          |      |              |          |
| **说明**     | 找到代码中继承方法和外层方法之间的潜在混淆。                 |          |      |              |          |
| **报告模式** | 1.      IA_AMBIGUOUS_INVOCATION_OF_INHERITED_OR_OUTER_METHOD  (IA, STYLE):  潜在的二义性继承方法或外层方法调用 |          |      |              |          |

 

**4.6 DuplicateBranches**

| **模式**     | DB                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.DuplicateBranches                 |          |      |              |          |
| **说明**     | 这个检测器会检查if/else或switch语句中是否有两个具有相同代码的分支，这种情况会降低测试的有用性。这通常是由于复制粘贴两条分支时造成的，会导致其中一条分支的逻辑不正确。 |          |      |              |          |
| **报告模式** | 1.      DB_DUPLICATE_BRANCHES  (DB, STYLE):  方法含有使用相同代码的两条分支2.      DB_DUPLICATE_SWITCH_CLAUSES  (DB, STYLE):  方法含有使用相同代码的两条switch子句 |          |      |              |          |

 

**4.7 FindBadForLoop**

| **模式**     | QF                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindBadForLoop                    |          |      |              |          |
| **说明**     | 这个检测器会找出代码中不正确的for循环。                      |          |      |              |          |
| **报告模式** | 1.      QF_QUESTIONABLE_FOR_LOOP  (QF, STYLE):  for循环中含有复杂的、难以捉摸的或错误的增量 |          |      |              |          |

 

**4.8 FindCircularDependencies**

| **模式**     | CD                                                           | **速度** | 中   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindCircularDependencies          |          |      |              |          |
| **说明**     | 这个检测器会找出类之间的环状依赖关系。                       |          |      |              |          |
| **报告模式** | 1.      CD_CIRCULAR_DEPENDENCY  (CD, STYLE):  测试类之间的环状依赖关系 |          |      |              |          |

 

**4.9 FindNonSerializableValuePassedToWriteObject**

| **模式**     | DMI                                                          | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindNonSerializableValuePassedToWriteObject |          |      |              |          |
| **说明**     | 这个检测器会找出代码中将不可序列化对象传递给一个ObjectOutput对象的writeObject方法的地方。 |          |      |              |          |
| **报告模式** | 1.      DMI_NONSERIALIZABLE_OBJECT_WRITTEN  (DMI, STYLE):  将不可序列化对象写入ObjectOutput |          |      |              |          |

 

**4.10 FindNonShortCircuit**

| **模式**     | NS                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindNonShortCircuit               |          |      |              |          |
| **说明**     | 这个检测器会找出代码中使用非短路布尔运算符（使用\|和&，而不是\|\|和&&）的可疑之处。 |          |      |              |          |
| **报告模式** | 1.      NS_DANGEROUS_NON_SHORT_CIRCUIT  (NS, STYLE):  使用非短路逻辑运算符的潜在危险2.      NS_NON_SHORT_CIRCUIT  (NS, STYLE):  非短路逻辑运算符的可疑使用 |          |      |              |          |

 

**4.11 FindUselessControlFlow**

| **模式**     | UCF                                                          | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindUselessControlFlow            |          |      |              |          |
| **说明**     | 这个检测器会找出代码中无效的控制流语句。                     |          |      |              |          |
| **报告模式** | 1.      UCF_USELESS_CONTROL_FLOW  (UCF, STYLE):  无用的控制流2.      UCF_USELESS_CONTROL_FLOW_NEXT_LINE  (UCF, STYLE):  指向下一行的无用的控制流 |          |      |              |          |

 

**4.12 InconsistentAnnotations**

| **模式**     | NP                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.InconsistentAnnotations           |          |      |              |          |
| **说明**     | 这个检测器会找出代码中直接应用于方法参数的类型修饰符和这些方法参数的实际使用之间的不一致性。 |          |      |              |          |
| **报告模式** | 1.      NP_PARAMETER_MUST_BE_NONNULL_BUT_MARKED_AS_NULLABLE  (NP, STYLE):  参数必须是非空的，但是却标记为可为空值 |          |      |              |          |

 

**4.13 LoadOfKnownNullValue**

| **模式**     | NP                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.LoadOfKnownNullValue              |          |      |              |          |
| **说明**     | 检查代码中加载明知为空的值的地方。                           |          |      |              |          |
| **报告模式** | 1.      NP_LOAD_OF_KNOWN_NULL_VALUE  (NP, STYLE):  加载已知为空的值 |          |      |              |          |

 

**4.14 MultithreadedInstanceAccess**

| **模式**     | MTIA                                                         | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.MultithreadedInstanceAccess       |          |      |              |          |
| **说明**     | 这个检测器会找出实现Struts框架时的潜在问题。                 |          |      |              |          |
| **报告模式** | 1.      MTIA_SUSPECT_SERVLET_INSTANCE_FIELD  (MTIA, STYLE):  类扩展Servlet类，并且使用实例变量2.      MTIA_SUSPECT_STRUTS_INSTANCE_FIELD  (MTIA, STYLE):  类扩展Struts的Action类，并且使用实例变量 |          |      |              |          |

 

**4.15 PreferZeroLengthArrays**

| **模式**     | PZLA                                                         | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.PreferZeroLengthArrays            |          |      |              |          |
| **说明**     | 这个检测器会找出返回值要么是数组，要么是空引用的方法。通常，当需要返回一个空引用时，返回一个长度为零的数组比较好。 |          |      |              |          |
| **报告模式** | 1.      PZLA_PREFER_ZERO_LENGTH_ARRAYS  (PZLA, STYLE):  考虑返回一个长度为零的数组，而不是返回空引用 |          |      |              |          |

 

**4.16 PublicSemaphores**

| **模式**     | PS                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.PublicSemaphores                  |          |      |              |          |
| **说明**     | 这个检测器会找出使用wait()、notify()、notifyAll()等方法进行同步操作的公有类。这样会将同步的实现方法作为这个类的公共信息暴露出来。这个类的客户程序可能会使用这个类的实例对象作为它自己的同步化对象，从而对基本实现造成严重破坏。 |          |      |              |          |
| **报告模式** | 1.      PS_PUBLIC_SEMAPHORES  (PS, STYLE):  类在它的公有接口中暴露了同步和信号量 |          |      |              |          |

 

**4.17 RedundantInterfaces**

| **模式**     | RI                                                           | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.RedundantInterfaces               |          |      |              |          |
| **说明**     | 这个检测器会找出声明实现的接口和父类实现的接口相同的类。如果父类实现了一个接口，那么子类也会实现这个接口，所以这是一种多余实现。 |          |      |              |          |
| **报告模式** | 1.      RI_REDUNDANT_INTERFACES  (RI, STYLE):  这个类和父类实现的接口相同 |          |      |              |          |

 

**4.18 RuntimeExceptionCapture**

| **模式**     | REC                                                          | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.RuntimeExceptionCapture           |          |      |              |          |
| **说明**     | 当代码块中没有任何代码抛出异常时，这个检测器会找出捕捉异常的catch子句。 |          |      |              |          |
| **报告模式** | 1.      REC_CATCH_EXCEPTION  (REC, STYLE):  没有抛出异常，但却捕捉异常 |          |      |              |          |

 

**4.19 UselessSubclassMethod**

| **模式**     | USM                                                          | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.UselessSubclassMethod             |          |      |              |          |
| **说明**     | 这个检测器会找出实现在父类中定义的方法的子类，子类仅仅通过将参数原封未动地传递给父类方法来实现这个方法。这些方法都是可以被移除的。 |          |      |              |          |
| **报告模式** | 1.      USM_USELESS_ABSTRACT_METHOD  (USM, STYLE):  抽象方法已经在已实现的接口中定义2.      USM_USELESS_SUBCLASS_METHOD  (USM, STYLE):  方法过分地委托给父类方法 |          |      |              |          |

 

**4.20 XMLFactoryBypass**

| **模式**     | XFB                                                          | **速度** | 快   | **缺陷类别** | 危险代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.XMLFactoryBypass                  |          |      |              |          |
| **说明**     | 这个检测器会找出XML接口实现的直接分配。这样会使代码依赖于一种特定的实现，而不是使用提供的工厂模式来创建这些对象。 |          |      |              |          |
| **报告模式** | 1.      XFB_XML_FACTORY_BYPASS  (XFB, STYLE):  方法直接分配XML接口的一种特定实现 |          |      |              |          |

 

**5.       Internationalization（国际化）**

**5.1 DefaultEncodingDetector**

| **模式**     | Dm                                                           | **速度** | 快   | **缺陷类别** | 国际化 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DefaultEncodingDetector           |          |      |              |        |
| **说明**     | 检查将byte转换为String（或者String转换为byte）的方法调用是否使用用户默认的平台编码。这样的方法调用会导致应用程序的行为可能会随着平台的不同而改变。 |          |      |              |        |
| **报告模式** | 1.      DM_DEFAULT_ENCODING  (Dm, I18N):  信任默认编码       |          |      |              |        |

 

**6.       Multithreaded Correctness（多线程正确性）**

**6.1 AtomicityProblem**

| **模式**     | AT                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.AtomicityProblem                  |          |      |              |        |
| **说明**     | 找到一个并发抽象上的不会原子性执行的操作（例如get/put方法）序列。 |          |      |              |        |
| **报告模式** | 1.      AT_OPERATION_SEQUENCE_ON_CONCURRENT_ABSTRACTION  (AT, MT_CORRECTNESS):  对并发抽象的调用序列可能不是原子性的 |          |      |              |        |

 

**6.2 DontIgnoreResultOfPutIfAbsent**

| **模式**     | RV                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DontIgnoreResultOfPutIfAbsent     |          |      |              |        |
| **说明**     | 检查如果putIfAbsent方法的结果被忽略，那么作为第二个参数传入的值没有被重用。 |          |      |              |        |
| **报告模式** | 1.      RV_RETURN_VALUE_OF_PUTIFABSENT_IGNORED  (RV, MT_CORRECTNESS):  忽略putIfAbsent方法的返回值，重用传入putIfAbsent方法的参数值 |          |      |              |        |

 

**6.3 FindDoubleCheck**

| **模式**     | DC                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindDoubleCheck                   |          |      |              |        |
| **说明**     | 这个检测器会找出代码中双重检查锁定的实例。                   |          |      |              |        |
| **报告模式** | 1.      DC_DOUBLECHECK  (DC, MT_CORRECTNESS):  可能的双重检查字段 |          |      |              |        |

 

**6.4 FindEmptySynchronizedBlock**

| **模式**     | ESync                                                        | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindEmptySynchronizedBlock        |          |      |              |        |
| **说明**     | 这个检测器会找出代码中空白的同步代码块。                     |          |      |              |        |
| **报告模式** | 1.      ESync_EMPTY_SYNC  (ESync, MT_CORRECTNESS):  空白的同步代码块 |          |      |              |        |

 

**6.5 FindInconsistentSync2**

| **模式**     | IS\|MSF                                                      | **速度** | 慢   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindInconsistentSync2             |          |      |              |        |
| **说明**     | 这个检测器会找出代码中通过一种相对于锁定而言不一致的方式访问字段的地方。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      IS2_INCONSISTENT_SYNC  (IS, MT_CORRECTNESS):  不一致的同步2.      IS_FIELD_NOT_GUARDED  (IS, MT_CORRECTNESS):  没有预防对字段的并发访问3.      MSF_MUTABLE_SERVLET_FIELD  (MSF, MT_CORRECTNESS):  可变的servlet字段 |          |      |              |        |

 

**6.6 FindJSR166LockMonitorenter**

| **模式**     | JLM                                                          | **速度** | 中   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindJSR166LockMonitorenter        |          |      |              |        |
| **说明**     | 这个检测器会找出代码中在JSR166锁上执行的普通同步。这个检测器的运行速度中等。 |          |      |              |        |
| **报告模式** | 1.      JLM_JSR166_LOCK_MONITORENTER  (JLM, MT_CORRECTNESS):  在Lock实例上执行同步方法2.      JLM_JSR166_UTILCONCURRENT_MONITORENTER  (JLM, MT_CORRECTNESS):  在util.concurrent实例上执行同步方法3.      JML_JSR166_CALLING_WAIT_RATHER_THAN_AWAIT  (JLM, MT_CORRECTNESS):  对util.concurrent抽象使用监控风格的wait方法 |          |      |              |        |

 

**6.7 FindMismatchedWaitOrNotify**

| **模式**     | MWN                                                          | **速度** | 中   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindMismatchedWaitOrNotify        |          |      |              |        |
| **说明**     | 不能对当前被锁定的对象调用wait()、notify()、notifyAll()等方法，这个检测器会找出代码中对当前被锁定对象调用这些方法的地方。这个检测器的运行速度中等。因为这个检测器仍然在开发之中，会产生很多错误的结果，所以一般不使用这个检测器。 |          |      |              |        |
| **报告模式** | 1.      MWN_MISMATCHED_NOTIFY  (MWN, MT_CORRECTNESS):  不匹配的notify()方法2.      MWN_MISMATCHED_WAIT  (MWN, MT_CORRECTNESS):  不匹配的wait()方法 |          |      |              |        |

 

**6.8 FindNakedNotify**

| **模式**     | NN                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindNakedNotify                   |          |      |              |        |
| **说明**     | 这个检测器会找出代码中看起来没有修改可变对象状态的notify()方法调用。 |          |      |              |        |
| **报告模式** | 1.      NN_NAKED_NOTIFY  (NN, MT_CORRECTNESS):  不确定的notify方法 |          |      |              |        |

 

**6.9 FindRunInvocations**

| **模式**     | Ru                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindRunInvocations                |          |      |              |        |
| **说明**     | 这个检测器会找出代码中对Thread.run()方法的调用。这个检测器的运行速度较快。 |          |      |              |        |
| **报告模式** | 1.      RU_INVOKE_RUN  (Ru, MT_CORRECTNESS):  调用一个线程对象的run方法（实际上你是想启动这个线程吗？） |          |      |              |        |

 

**6.10 FindSleepWithLockHeld**

| **模式**     | SWL                                                          | **速度** | 慢   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindSleepWithLockHeld             |          |      |              |        |
| **说明**     | 这个检测器会找出代码中调用Thread.sleep()方法，同时又保持锁的地方。这个检测器的速度较慢。 |          |      |              |        |
| **报告模式** | 1.      SWL_SLEEP_WITH_LOCK_HELD  (SWL, MT_CORRECTNESS):  方法调用Thread.sleep()方法，同时又不释放锁 |          |      |              |        |

 

**6.11 FindSpinLoop**

| **模式**     | SP                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindSpinLoop                      |          |      |              |        |
| **说明**     | 这个检测器会找出代码中自旋读取一个字段的循环（自旋锁）。     |          |      |              |        |
| **报告模式** | 1.      SP_SPIN_ON_FIELD  (SP, MT_CORRECTNESS):  方法自旋竞争字段 |          |      |              |        |

 

**6.12 FindTwoLockWait**

| **模式**     | TLW                                                          | **速度** | 慢   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindTwoLockWait                   |          |      |              |        |
| **说明**     | 这个检测器会找出代码中调用wait()方法，同时又保持两个（或更多个）锁的地方。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      TLW_TWO_LOCK_WAIT  (TLW, MT_CORRECTNESS):  线程等待，但是同时又保持两个锁 |          |      |              |        |

 

**6.13 FindUnconditionalWait**

| **模式**     | UW                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUnconditionalWait             |          |      |              |        |
| **说明**     | 这个检测器会找出代码中没有在条件代码块或循环代码块中调用的wait()方法。 |          |      |              |        |
| **报告模式** | 1.      UW_UNCOND_WAIT  (UW, MT_CORRECTNESS):  无条件的等待  |          |      |              |        |

 

**6.14 FindUnreleasedLock**

| **模式**     | UL                                                           | **速度** | 中   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUnreleasedLock                |          |      |              |        |
| **说明**     | 这个检测器会找出代码中已经获得但是退出方法时没有释放的JSR-166（java.util.concurrent）锁。这个检测器的运行速度中等。注意，为了使用这个检测器，你需要在辅助的classpath中导入java.util.concurrent包（或者由它自己分析这个包）。 |          |      |              |        |
| **报告模式** | 1.      UL_UNRELEASED_LOCK  (UL, MT_CORRECTNESS):  方法在所有执行路径上都没有释放锁2.      UL_UNRELEASED_LOCK_EXCEPTION_PATH  (UL, MT_CORRECTNESS):  方法在所有异常路径上都没有释放锁 |          |      |              |        |

 

**6.15 FindUnsyncGet**

| **模式**     | UG                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUnsyncGet                     |          |      |              |        |
| **说明**     | 这个检测器会检查代码中的get/set方法，找出get方法是非同步而set方法是同步的get/set方法对。 |          |      |              |        |
| **报告模式** | 1.      UG_SYNC_SET_UNSYNC_GET  (UG, MT_CORRECTNESS):  非同步的get方法，同步的set方法 |          |      |              |        |

 

**6.16 LazyInit**

| **模式**     | LI                                                           | **速度** | 中   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.LazyInit                          |          |      |              |        |
| **说明**     | 这个检测器会找出代码中不是volatile，但是延迟字段初始化的字段。这个检测器的运行速度中等。 |          |      |              |        |
| **报告模式** | 1.      LI_LAZY_INIT_STATIC  (LI, MT_CORRECTNESS):  静态字段的不正确的延迟初始化2.      LI_LAZY_INIT_UPDATE_STATIC  (LI, MT_CORRECTNESS):  静态字段的不正确的延迟初始化和更新 |          |      |              |        |

 

**6.17 MutableLock**

| **模式**     | ML                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.MutableLock                       |          |      |              |        |
| **说明**     | 这个检测器会找出代码中对被修改字段的同步对象读取操作。       |          |      |              |        |
| **报告模式** | 1.      ML_SYNC_ON_UPDATED_FIELD  (ML, MT_CORRECTNESS):  方法对一个更新字段进行同步操作 |          |      |              |        |

 

**6.18 StartInConstructor**

| **模式**     | SC                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.StartInConstructor                |          |      |              |        |
| **说明**     | 这个检测器会找出启动线程的构造器。                           |          |      |              |        |
| **报告模式** | 1.      SC_START_IN_CTOR  (SC, MT_CORRECTNESS):  调用Thread.start()方法的构造器 |          |      |              |        |

 

**6.19 StaticCalendarDetector**

| **模式**     | STCAL                                                        | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.StaticCalendarDetector            |          |      |              |        |
| **说明**     | 这个检测器会发出关于java.util.Calendar或java.text.DateFormat类型（及其子类）的静态字段的警报，因为Calendar在使用多线程的情况下是天生不安全的。 |          |      |              |        |
| **报告模式** | 1.      STCAL_INVOKE_ON_STATIC_CALENDAR_INSTANCE  (STCAL, MT_CORRECTNESS):  调用静态Calendar2.      STCAL_INVOKE_ON_STATIC_DATE_FORMAT_INSTANCE  (STCAL, MT_CORRECTNESS):  调用静态DateFormat3.      STCAL_STATIC_CALENDAR_INSTANCE  (STCAL, MT_CORRECTNESS):  静态Calendar字段4.      STCAL_STATIC_SIMPLE_DATE_FORMAT_INSTANCE  (STCAL, MT_CORRECTNESS):  静态DateFormat字段 |          |      |              |        |

 

**6.20 SynchronizationOnSharedBuiltinConstant**

| **模式**     | DL                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SynchronizationOnSharedBuiltinConstant |          |      |              |        |
| **说明**     | 这个检测器会找出代码中对一个共享内建常量（例如String）进行同步操作的地方。 |          |      |              |        |
| **报告模式** | 1.      DL_SYNCHRONIZATION_ON_BOOLEAN  (DL, MT_CORRECTNESS):  对Boolean进行同步2.      DL_SYNCHRONIZATION_ON_BOXED_PRIMITIVE  (DL, MT_CORRECTNESS):  对封装的基本类型进行同步3.      DL_SYNCHRONIZATION_ON_SHARED_CONSTANT  (DL, MT_CORRECTNESS):  对内部String进行同步4.      DL_SYNCHRONIZATION_ON_UNSHARED_BOXED_PRIMITIVE  (DL, MT_CORRECTNESS):  对封装的基本类型值进行同步 |          |      |              |        |

 

**6.21 SynchronizeAndNullCheckField**

| **模式**     | NP                                                           | **速度** | 中   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SynchronizeAndNullCheckField      |          |      |              |        |
| **说明**     | 这个检测器会找出代码中进行同步操作，然后又检查是否为空值的字段。 |          |      |              |        |
| **报告模式** | 1.      NP_SYNC_AND_NULL_CHECK_FIELD  (NP, MT_CORRECTNESS):  对同一个字段进行同步和空值检查 |          |      |              |        |

 

**6.22 SynchronizeOnClassLiteralNotGetClass**

| **模式**     | WL                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SynchronizeOnClassLiteralNotGetClass |          |      |              |        |
| **说明**     | 找出代码中对getClass方法的结果进行同步操作，而不是对类常量进行同步操作的地方。 |          |      |              |        |
| **报告模式** | 1.      WL_USING_GETCLASS_RATHER_THAN_CLASS_LITERAL  (WL, MT_CORRECTNESS):  对getClass同步，而不是对类常量同步 |          |      |              |        |

 

**6.23 SynchronizingOnContentsOfFieldToProtectedField**

| **模式**     | ML                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.SynchronizingOnContentsOfFieldToProtectField |          |      |              |        |
| **说明**     | 这个检测器会找出代码中为了保护某个字段的更新而对这个字段进行同步操作的地方。 |          |      |              |        |
| **报告模式** | 1.      ML_SYNC_ON_FIELD_TO_GUARD_CHANGING_THAT_FIELD  (ML, MT_CORRECTNESS):  为了守护这个字段，尝试对这个字段进行无效的同步操作 |          |      |              |        |

 

**6.24 VolatileUsage**

| **模式**     | VO                                                           | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.VolatileUsage                     |          |      |              |        |
| **说明**     | 找出使用volatile字段时的缺陷模式。                           |          |      |              |        |
| **报告模式** | 1.      VO_VOLATILE_INCREMENT  (VO, MT_CORRECTNESS):  对一个volatile字段的增量操作不是原子性的2.      VO_VOLATILE_REFERENCE_TO_ARRAY  (VO, MT_CORRECTNESS):  一个指向数组的volatile引用没有将数组元素当做volatile的 |          |      |              |        |

 

**6.25 WaitInLoop**

| **模式**     | No\|Wa                                                       | **速度** | 快   | **缺陷类别** | 多线程 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.WaitInLoop                        |          |      |              |        |
| **说明**     | 这个检测器会找出代码中没有在循环中调用的wait()方法。         |          |      |              |        |
| **报告模式** | 1.      NO_NOTIFY_NOT_NOTIFYALL  (No, MT_CORRECTNESS):  使用notify()方法，而不是notifyAll()方法2.      WA_AWAIT_NOT_IN_LOOP  (Wa, MT_CORRECTNESS):  没有在循环中调用Condition.await()方法3.      WA_NOT_IN_LOOP  (Wa, MT_CORRECTNESS):  没有在循环中等待 |          |      |              |        |

 

**7.       Performance（性能）**

**7.1 FindUncalledPrivateMethods**

| **模式**     | UPM                                                          | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.FindUncalledPrivateMethods        |          |      |              |      |
| **说明**     | 这个检测器会找出从未调用过的私有方法。                       |          |      |              |      |
| **报告模式** | 1.      UPM_UNCALLED_PRIVATE_METHOD  (UPM, PERFORMANCE):  从未调用过的私有方法 |          |      |              |      |

 

**7.2 HugeSharedStringConstants**

| **模式**     | HSC                                                          | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.HugeSharedStringConstants         |          |      |              |      |
| **说明**     | 这个检测器会找出在多个class文件中重复出现的字符串常量。      |          |      |              |      |
| **报告模式** | 1.      HSC_HUGE_SHARED_STRING_CONSTANT  (HSC, PERFORMANCE):  大量的字符串常量在多个class文件中重复出现 |          |      |              |      |

 

**7.3 InefficientMemberAccess**

| **模式**     | IMA                                                          | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.InefficientMemberAccess           |          |      |              |      |
| **说明**     | 当一个类含有私有（private）成员变量和内部类时，这个检测器会找出试图写入这个类的私有成员变量的内部类。在这种情况下，需要使用一个生成存取器方法的特殊编译器来写入这个变量。将可见性放宽至受保护的（protected）将会使得这个字段能够被直接写入。 |          |      |              |      |
| **报告模式** | 1.      IMA_INEFFICIENT_MEMBER_ACCESS  (IMA, PERFORMANCE):  内部类的方法访问宿主类的一个私有成员变量 |          |      |              |      |

 

**7.4 InefficientToArray**

| **模式**     | ITA                                                          | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.InefficientToArray                |          |      |              |      |
| **说明**     | 当使用需要一个原型数组作为参数的toArray()方法将Collection对象转换为数组时，这个检测器会找出代码中向这个toArray()方法传递一个长度为零的数组实参的地方。 |          |      |              |      |
| **报告模式** | 1.      ITA_INEFFICIENT_TO_ARRAY  (ITA, PERFORMANCE):  方法通过长度为零的数组实参调用toArray()方法 |          |      |              |      |

 

**7.5 NumberConstructor**

| **模式**     | Bx                                                           | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.NumberConstructor                 |          |      |              |      |
| **说明**     | 找出代码中通过基本类型的实参调用Number类构造器的地方。       |          |      |              |      |
| **报告模式** | 1.      DM_FP_NUMBER_CTOR  (Bx, PERFORMANCE):  方法调用无效的浮点数Number类构造器，请使用valueOf静态方法代替2.      DM_NUMBER_CTOR  (Bx, PERFORMANCE):  方法调用无效的Number构造器，请使用valueOf静态方法代替 |          |      |              |      |

 

**7.6 StringConcatenation**

| **模式**     | SBSC                                                         | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.StringConcatenation               |          |      |              |      |
| **说明**     | 这个检测器会找出在循环中使用“+”运算符拼接字符串的地方。      |          |      |              |      |
| **报告模式** | 1.      SBSC_USE_STRINGBUFFER_CONCATENATION  (SBSC, PERFORMANCE):  方法在一个循环中使用“+”运算符拼接字符串 |          |      |              |      |

 

**7.7 URLProblems**

| **模式**     | Dm                                                           | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.URLProblems                       |          |      |              |      |
| **说明**     | 对java.net.URL调用equals和hashCode方法可以解析域名。结果，这些操作的开销可能非常高昂，这个检测器会找出代码中可能调用此类方法的地方。 |          |      |              |      |
| **报告模式** | 1.      DMI_BLOCKING_METHODS_ON_URL  (Dm, PERFORMANCE):  URL的equals和hashCode方法正在阻塞2.      DMI_COLLECTION_OF_URLS  (Dm, PERFORMANCE):  URL的Map和Set可能会导致性能问题 |          |      |              |      |

 

**7.8 UnnecessaryMath**

| **模式**     | UM                                                           | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.UnnecessaryMath                   |          |      |              |      |
| **说明**     | 这个检测器会找出代码中对常数值调用java.lang.Math的静态方法，而所得结果值也是一个静态已知的常数值的地方。直接使用常数值的速度更快，有时也更加精确。 |          |      |              |      |
| **报告模式** | 1.      UM_UNNECESSARY_MATH  (UM, PERFORMANCE):  方法对一个常数值调用Math类的静态方法 |          |      |              |      |

 

**7.9 WrongMapIterator**

| **模式**     | WMI                                                          | **速度** | 快   | **缺陷类别** | 性能 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---- |
| **类型**     | edu.umd.cs.findbugs.detect.WrongMapIterator                  |          |      |              |      |
| **说明**     | 这个检测器会找出代码中通过从一个keySet迭代器取得的一个键，访问Map中相应条目的值的地方。 |          |      |              |      |
| **报告模式** | 1.      WMI_WRONG_MAP_ITERATOR  (WMI, PERFORMANCE):  使用keySet迭代器无效，请使用entrySet迭代器代替 |          |      |              |      |

 

**8.       Malicious Code Vulnerability（恶意代码漏洞）**

**8.1 DoInsideDoPrivileged**

| **模式**     | DP                                                           | **速度** | 快   | **缺陷类别** | 恶意代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.DoInsideDoPrivileged              |          |      |              |          |
| **说明**     | 找出应当在doPrivileged代码块中执行的代码。                   |          |      |              |          |
| **报告模式** | 1.      DP_CREATE_CLASSLOADER_INSIDE_DO_PRIVILEGED  (DP, MALICIOUS_CODE):  应当只能在doPrivileged代码块中创建类加载器2.      DP_DO_INSIDE_DO_PRIVILEGED  (DP, MALICIOUS_CODE):  调用了应当只能在doPrivileged代码块中调用的方法 |          |      |              |          |

 

**8.2 FindReturnRef**

| **模式**     | EI\|EI2\|MS                                                  | **速度** | 快   | **缺陷类别** | 恶意代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.FindReturnRef                     |          |      |              |          |
| **说明**     | 这个检测器会找出返回可变静态数据的方法。                     |          |      |              |          |
| **报告模式** | 1.      EI_EXPOSE_REP  (EI, MALICIOUS_CODE):  返回指向可变对象的引用可能会暴露内部表示法2.      EI_EXPOSE_REP2  (EI2, MALICIOUS_CODE):  结合指向可变对象的引用可能会暴露内部表示法3.      EI_EXPOSE_STATIC_REP2  (MS, MALICIOUS_CODE):  将一个可变对象存储在一个静态字段中可能会暴露内部静态状态4.      MS_EXPOSE_REP  (MS, MALICIOUS_CODE):  返回数组的公有静态方法可能会暴露内部表示法 |          |      |              |          |

 

**8.3 MutableStaticFields**

| **模式**     | MS                                                           | **速度** | 快   | **缺陷类别** | 恶意代码 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | -------- |
| **类型**     | edu.umd.cs.findbugs.detect.MutableStaticFields               |          |      |              |          |
| **说明**     | 这个检测器会找出可能会被恶意代码篡改的静态字段。             |          |      |              |          |
| **报告模式** | 1.      MS_CANNOT_BE_FINAL  (MS, MALICIOUS_CODE):  字段不是finale的，不能防止恶意代码的修改2.      MS_FINAL_PKGPROTECT  (MS, MALICIOUS_CODE):  字段应当既是final的，又是package或protected的3.      MS_MUTABLE_ARRAY  (MS, MALICIOUS_CODE):  字段是一个可变数组4.      MS_MUTABLE_HASHTABLE  (MS, MALICIOUS_CODE):  字段是一个可变哈希表5.      MS_OOI_PKGPROTECT  (MS, MALICIOUS_CODE):  应当将字段从一个接口中抽出，并且将其设为package或者protected6.      MS_PKGPROTECT  (MS, MALICIOUS_CODE):  字段应当是package或protected7.      MS_SHOULD_BE_FINAL  (MS, MALICIOUS_CODE):  字段不是final的，但应当是final的8.      MS_SHOULD_BE_REFACTORED_TO_BE_FINAL  (MS, MALICIOUS_CODE):  字段不是final的，但是应当将其重构为final的 |          |      |              |          |

 

**9.       Bogus Random Noise（伪随机噪声）**

**9.1 Noise**

| **模式**     | NOISE                                                        | **速度** | 快   | **缺陷类别** | 伪随机噪声 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---------- |
| **类型**     | edu.umd.cs.findbugs.detect.Noise                             |          |      |              |            |
| **说明**     | 这个检测器会产生一个随机信号：基于方法执行操作所产生的散列值的警告。这些警告都是伪随机噪声，它们是数据挖掘实验中的一种有用的控制手段，并不是用来发现软件中的实际缺陷。这个检测器只是一个用于测试新检测器的挂钩。通常，这个检测器不会处理任何事情。 |          |      |              |            |
| **报告模式** | 1.      NOISE_FIELD_REFERENCE  (NOISE, NOISE):  字段引用相关的假警告2.      NOISE_METHOD_CALL  (NOISE, NOISE):  方法调用相关的假警告3.      NOISE_OPERATION  (NOISE, NOISE):  运算相关的假警告 |          |      |              |            |

 

**9.2 NoiseNullDeref**

| **模式**     | NOISE                                                        | **速度** | 快   | **缺陷类别** | 伪随机噪声 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ---------- |
| **类型**     | edu.umd.cs.findbugs.detect.NoiseNullDeref                    |          |      |              |            |
| **说明**     | 用于空指针解引用的噪声检测器。主要作为警告的有效性或预测能力实验中的一种有用的控制手段，而不是用来发现代码中的实际缺陷。 |          |      |              |            |
| **报告模式** | 1.      NOISE_NULL_DEREFERENCE  (NOISE, NOISE):  空指针解引用相关的假警告 |          |      |              |            |

 

**10.  Experimental（实验性）**

**10.1 FindUnsatisfiedObligation**

| **模式**     | OBL                                                          | **速度** | 慢   | **缺陷类别** | 实验性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindUnsatisfiedObligation         |          |      |              |        |
| **说明**     | 这个检测器会找出在所有执行路径中都没有对使用的I/O流和数据库资源进行清理的方法。这个检测器的运行速度较慢。 |          |      |              |        |
| **报告模式** | 1.      OBL_UNSATISFIED_OBLIGATION  (OBL, EXPERIMENTAL):  方法可能未能成功清理流或资源2.      OBL_UNSATISFIED_OBLIGATION_EXCEPTION_EDGE  (OBL, EXPERIMENTAL):  在处理异常时，方法可能未能成功清理流或资源 |          |      |              |        |

 

**10.2 LostLoggerDueToWeakReference**

| **模式**     | LG                                                           | **速度** | 快   | **缺陷类别** | 实验性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.LostLoggerDueToWeakReference      |          |      |              |        |
| **说明**     | 这个检测器会找出在OpenJDK 1.6下行为不同的代码，OpenJDK使用弱引用来维持日志记录器。 |          |      |              |        |
| **报告模式** | 1.      LG_LOST_LOGGER_DUE_TO_WEAK_REFERENCE  (LG, EXPERIMENTAL):  OpenJDK中的弱引用具有导致日志记录器丢失的风险 |          |      |              |        |

 

**10.3 TestASM**

| **模式**     | TEST                                                         | **速度** | 快   | **缺陷类别** | 实验性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.TestASM                           |          |      |              |        |
| **说明**     | 这个检测器是一个代码示例，示范如何使用ASM字节码分析框架编写一个FindBugs检测器。 |          |      |              |        |
| **报告模式** | 1.      TESTING  (TEST, EXPERIMENTAL):  测试                 |          |      |              |        |

 

**10.4 TestingGround**

| **模式**     | TEST                                                         | **速度** | 快   | **缺陷类别** | 实验性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.TestingGround                     |          |      |              |        |
| **说明**     | 这个检测器仅仅是一个用于测试新检测器的钩子。通常，这个检测器不会做任何事情。 |          |      |              |        |
| **报告模式** | 1.      TESTING  (TEST, EXPERIMENTAL):  测试                 |          |      |              |        |

 

**10.5 TestingGround2**

| **模式**     | TEST                                                         | **速度** | 快   | **缺陷类别** | 实验性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.TestingGround2                    |          |      |              |        |
| **说明**     | 这个检测器仅仅是一个用于测试新检测器的钩子。通常，这个检测器不会做任何事情。 |          |      |              |        |
| **报告模式** | 1.      TESTING  (TEST, EXPERIMENTAL):  测试                 |          |      |              |        |

 

**11.  Security（安全性）**

**11.1 CrossSiteScripting**

| **模式**     | HRS\|PT\|XSS                                                 | **速度** | 快   | **缺陷类别** | 安全性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.CrossSiteScripting                |          |      |              |        |
| **说明**     | 这个检测器会找出明显的跨站点脚本漏洞。                       |          |      |              |        |
| **报告模式** | 1.      HRS_REQUEST_PARAMETER_TO_COOKIE  (HRS, SECURITY):  HTTP的cookie形成于不受信任的输入2.      HRS_REQUEST_PARAMETER_TO_HTTP_HEADER  (HRS, SECURITY):  HTTP响应分割漏洞3.      PT_ABSOLUTE_PATH_TRAVERSAL  (PT, SECURITY):  servlet中的绝对路径遍历4.      PT_RELATIVE_PATH_TRAVERSAL  (PT, SECURITY):  servlet中的相对路径遍历5.      XSS_REQUEST_PARAMETER_TO_JSP_WRITER  (XSS, SECURITY):  JSP反射跨站点脚本漏洞6.      XSS_REQUEST_PARAMETER_TO_SEND_ERROR  (XSS, SECURITY):  错误页面中的servlet反射跨站点脚本漏洞7.      XSS_REQUEST_PARAMETER_TO_SERVLET_WRITER  (XSS, SECURITY):  servlet反射跨站点脚本漏洞 |          |      |              |        |

 

**11.2 FindSqlInjection**

| **模式**     | SQL                                                          | **速度** | 中   | **缺陷类别** | 安全性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.FindSqlInjection                  |          |      |              |        |
| **说明**     | 这个检测器会通过数据流分析检查执行SQL语句的方法调用，找出那些没有使用常量字符串作为实参的方法调用。 |          |      |              |        |
| **报告模式** | 1.      SQL_NONCONSTANT_STRING_PASSED_TO_EXECUTE  (SQL, SECURITY):  传递给SQL语句执行方法的参数是非常量字符串2.      SQL_PREPARED_STATEMENT_GENERATED_FROM_NONCONSTANT_STRING  (SQL, SECURITY):  一条准备好的语句是由一个非常量字符串生成的 |          |      |              |        |

 

**11.3 DumbMethodInvocations**

| **模式**     | Dm\|DMI                                                      | **速度** | 快   | **缺陷类别** | 安全性 |
| ------------ | ------------------------------------------------------------ | -------- | ---- | ------------ | ------ |
| **类型**     | edu.umd.cs.findbugs.detect.DumbMethodInvocations             |          |      |              |        |
| **说明**     | 这个检测器会找出传递给方法的错误参数（例如，substring(0)）。 |          |      |              |        |
| **报告模式** | 1.      DMI_CONSTANT_DB_PASSWORD  (Dm, SECURITY):  数据库密码的硬编码常量2.      DMI_EMPTY_DB_PASSWORD  (Dm, SECURITY):  空的数据库密码3.      DMI_HARDCODED_ABSOLUTE_FILENAME  (DMI, STYLE):  代码含有指向一个绝对路径名的硬编码引用4.      DMI_USELESS_SUBSTRING  (DMI, STYLE):  调用substring(0)方法会返回原始值 |          |      |              |        |

 

ref:

1.[详解FindBugs的各项检测器](https://blog.csdn.net/yang1982_0907/article/details/18606171)





 