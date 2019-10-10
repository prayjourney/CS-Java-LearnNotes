### FindBugs错误信息

***

#### 提示信息：

EI: May expose internal representation by returning reference to mutable object (EI_EXPOSE_REP) 
Returning a reference to a mutable object value stored in one of the object’s fields exposes the internal representation of the object. If instances are accessed by untrusted code, and unchecked changes to the mutable object would compromise security or other important properties, you will need to do something different. Returning a new copy of the object is better approach in many situations. 
EI：可以通过返回对可变对象的引用来公开内部表示 
返回对存储在对象的一个字段中的可变对象值的引用会公开对象的内部表示。如果不受信任的代码访问实例，并且对可变对象的未经检查的更改会危及安全性或其他重要属性。在许多情况下，返回对象的新副本是更好的方法。

#### 原代码：

```java
    /**
     * 获取：创建时间
     */
    public Date getGmtCreate() {
        return gmtCreate;
    }
```

#### 修改后代码：

```java
    /**
     * 获取：创建时间
     */
    public Date getGmtCreate() {
        if (this.gmtCreate != null) {
            return new Date(this.gmtCreate.getTime());
        } else {
            return null;
        }
    }
```

#### 提示信息：

EI2: May expose internal representation by incorporating reference to mutable object (EI_EXPOSE_REP2) 
This code stores a reference to an externally mutable object into the internal representation of the object. If instances are accessed by untrusted code, and unchecked changes to the mutable object would compromise security or other important properties, you will need to do something different. Storing a copy of the object is better approach in many situations. 
EI2：可以通过引用可变对象来公开内部表示 
此代码将对外部可变对象的引用存储到对象的内部表示中。如果不受信任的代码访问实例，并且对可变对象的未经检查的更改会危及安全性或其他重要属性。在许多情况下，存储对象的副本是更好的方法。

#### 原代码：

```java
    /**
     * 设置：创建时间
     */
    public void setGmtCreate(Date gmtCreate) {
        this.gmtCreate = gmtCreate;
    }
```

#### 修改后代码：

```java
    /**
     * 设置：创建时间
     */
    public void setGmtCreate(Date gmtCreate) {
        if (gmtCreate != null) {
            this.gmtCreate = (Date) gmtCreate.clone();
        } else {
            this.gmtCreate = null;
        }
    }
```



ref:
1.[FindBugs EI_EXPOSE_REP EI_EXPOSE_REP2](https://blog.csdn.net/pythonerxxs/article/details/81026322)