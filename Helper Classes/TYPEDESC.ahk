/*
class: TYPEDESC
a structure class that describes the type of a variable, the return type of a function, or the type of a function parameter.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lpgl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/AHK_Lv1.1/TYPEDESC)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/ms221162%28v=VS.85%29.aspx)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - (unknown)
	Base classes - _CCF_Error_Handler_, StructBase
	Helper classes - VARENUM, (ARRAYDESC)
*/
class TYPEDESC extends StructBase
{
	/*
	Field: lptdesc
	If <vt> contains VARENUM.PTR or VARENUM.ARRAY, this contains a TYPEDESC that specifies the element type.

	Remarks:
		As <lptdesc>, <lpadesc> and <hreftype> are in an union, only one of them can be present at the same time.
	*/
	lptdesc := new TYPEDESC()

	/*
	Field: lpadesc
	If <vt> is VARENUM.CARRAY, contains a description of the array.

	Remarks:
		As <lptdesc>, <lpadesc> and <hreftype> are in an union, only one of them can be present at the same time.
	*/
	lpadesc := new ARRAYDESC()

	/*
	Field: hreftype
	With VARENUM.USER_DEFINED, this is used to get a TypeInfo for the user-defined type.

	Remarks:
		As <lptdesc>, <lpadesc> and <hreftype> are in an union, only one of them can be present at the same time.
	*/
	hreftype := 0

	/*
	Field: vt
	Defines the type of the variable. You may use the fields of the VARENUM class for convenience.
	*/
	vt := 0

	/*
	Method: ToStructPtr
	converts the instance to a script-usable struct and returns its memory adress.

	Parameters:
		[opt] UPTR ptr - the fixed memory address to copy the struct to.

	Returns:
		UPTR ptr - a pointer to the struct in memory
	*/
	ToStructPtr(ptr = 0)
	{
		if (!ptr)
		{
			ptr := this.Allocate(this.GetRequiredSize())
		}

		if ((this.vt & VARENUM.PTR) == VARENUM.PTR || (this.vt & VARENUM.ARRAY) == VARENUM.ARRAY)
		{
			NumPut(this.lptdesc.ToStructPtr(),	1*ptr,	00,	"UPtr")
		}
		else if ((this.vt & VARENUM.CARRAY) == VARENUM.CARRAY)
		{
			NumPut(this.lpadesc.ToStructPtr(),	1*ptr,	00,	"UPtr")
		}
		else if ((this.vt & VARENUM.USER_DEFINED) == VARENUM.USER_DEFINED)
		{
			NumPut(this.hreftype,	1*ptr,	00,	"UInt")
		}
		NumPut(this.vt,		1*ptr,	A_PtrSize,	"UInt")

		return ptr
	}

	/*
	Method: FromStructPtr
	(static) method that converts a script-usable struct into a new instance of the class.

	Parameters:
		UPTR ptr - a pointer to a TYPEDESC struct in memory

	Returns:
		TYPEDESC instance - the new TYPEDESC instance
	*/
	FromStructPtr(ptr)
	{
		local instance := new TYPEDESC()

		instance.vt := NumGet(1*ptr, A_PtrSize, "UInt")
		if ((instance.vt & VARENUM.PTR) == VARENUM.PTR || (instance.vt & VARENUM.ARRAY) == VARENUM.ARRAY)
		{
			instance.lptdesc := TYPEDESC.FromStructPtr(NumGet(1*ptr, 00, "UPtr"))
		}
		else if ((instance.vt & VARENUM.CARRAY) == VARENUM.CARRAY)
		{
			instance.lpadesc := ARRAYDESC.FromStructPtr(NumGet(1*ptr, 00, "UPtr"))
		}
		else if ((instance.vt & VARENUM.USER_DEFINED) == VARENUM.USER_DEFINED)
		{
			instance.hreftype := NumGet(1*ptr, 00, "UInt")
		}

		return instance
	}

	/*
	Method: GetRequiredSize
	calculates the size a memory instance of this class requires.

	Parameters:
		[opt] OBJECT data - an optional data object that may cotain data for the calculation.

	Returns:
		UINT bytes - the number of bytes required

	Remarks:
		- This may be called as if it was a static method.
		- The data object is ignored by this class.
	*/
	GetRequiredSize(data = "")
	{
		return A_PtrSize + 4
	}
}