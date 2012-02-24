/*
class: OperationsProgressDialog
wraps the *IOperationsProgressDialog* interface and exposes methods to get, set, and query a progress dialog.

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Documentation:
	- *class documentation* (http://maul-esel.github.com/COM-Classes/master/OperationsProgressDialog)
	- *msdn* (http://msdn.microsoft.com/en-us/library/windows/desktop/bb775368)

Requirements:
	AutoHotkey - AHK v2 alpha
	OS - Windows 2000 Professional, Windows XP, Windows 2000 Server or higher
	Base classes - _CCF_Error_Handler_, Unknown
	Constant classes - PROGDLG, PDOPSTATUS, PMODE
*/
class OperationsProgressDialog extends Unknown
{
	/*
	Field: CLSID
	This is CLSID_ProgressDialog. It is required to create an instance.
	*/
	static CLSID := "{F8383852-FCD3-11d1-A6B9-006097DF5BD4}"

	/*
	Field: IID
	This is IID_IOperationsProgressDialog. It is required to create an instance.
	*/
	static IID := "{0C9FB851-E5C9-43EB-A370-F0677B13874C}"

	/*
	Method: StartProgressDialog
	Starts the progress dialog.

	Parameters:
		[opt] HWND hParent - the handle to the parent window
		[opt] UINT flags - a combination fo flags modifying the dialog. You can use the fields of the PROGDLG class for convenience.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	StartProgressDialog(hParent := 0, flags := 0)
	{
		return this._Error(DllCall(NumGet(this.vt, 03*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", hParent, "UInt", flags, "Int"))
	}

	/*
	Method: StopProgressDialog
	Stops the progress dialog.

	Returns:
		BOOL success - true on success, false otherwise
	*/	
	StopProgressDialog()
	{
		return this._Error(DllCall(NumGet(this.vt, 04*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int"))
	}

	/*
	Method: SetOperation
	Sets which progress dialog operation is occurring.

	Parameters:
		UINT operation - the operation to perform. You can use the fields of the SPACTION class for convenience.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetOperation(operation)
	{
		return this._Error(DllCall(NumGet(this.vt, 05*A_PtrSize, "Ptr"), "Ptr", this.ptr, "UInt", operation, "Int"))
	}

	/*
	Method: SetMode
	Sets progress dialog operations mode.

	Parameters:
		UINT mode - the operation mode. You can use the fields of the PMODE class for convenience.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	SetMode(mode)
	{
		return this._Error(DllCall(NumGet(this.vt, 06*A_PtrSize, "Ptr"), "Ptr", this.ptr, "UInt", mode, "Int"))
	}

	/*
	Method: UpdateProgress

	Parameters:
		UINT64 pointsReached - Current points, used for showing progress in points. (progressbar)
		UINT64 pointsTotal - Total points, used for showing progress in points.
		UINT64 sizeReached - Current size in bytes, used for showing progress in bytes.
		UINT64 sizeTotal - total size in bytes, used for showing progress in bytes.
		UINT64 itemsReached - Current items, used for showing progress in items.
		UINT64 itemsTotal - Specifies total items, used for showing progress in items.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	UpdateProgress(pointsReached, pointsTotal, sizeReached, sizeTotal, itemsReached, itemsTotal)
	{
		return this._Error(DllCall(NumGet(this.vt, 07*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int64", pointsReached, "Int64", pointsTotal, "Int64", sizeReached, "Int64", sizeTotal, "Int64", itemsReached, "Int64", itemsTotal, "Int"))
	}

	/*
	Method: UpdateLocations
	Called to specify the text elements stating the source and target in the current progress dialog.

	Parameters:
		IShellItem source - the pointer to an IShellItem that represents the source Shell item.
		IShellItem target - the pointer to an IShellItem that represents the target Shell item.
		[opt] IShellItem item - *Win7 and later:* A pointer to an IShellItem that represents the item currently being operated on by the operation engine.

	Returns:
		BOOL success - true on success, false otherwise

	Remarks:
		You can either pass raw pointers or ShellItem instances to this method.
	*/
	UpdateLocations(source, target, item := 0)
	{
		return this._Error(DllCall(NumGet(this.vt, 08*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Ptr", IsObject(source) ? source.ptr : source, "Ptr", IsObject(target) ? target.ptr : target, "Ptr", IsObject(item) ? item.ptr : item, "Int"))
	}

	/*
	Method: ResetTimer
	Resets progress dialog timer to 0.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	ResetTimer()
	{
		return this._Error(DllCall(NumGet(this.vt, 09*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int"))
	}

	/*
	Method: PauseTimer
	Pauses progress dialog timer.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	PauseTimer()
	{
		return this._Error(DllCall(NumGet(this.vt, 10*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int"))
	}

	/*
	Method: ResumeTimer
	Resumes progress dialog timer.

	Returns:
		BOOL success - true on success, false otherwise
	*/
	ResumeTimer()
	{
		return this._Error(DllCall(NumGet(this.vt, 11*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int"))
	}

	/*
	Method: GetMilliseconds
	Gets elapsed and remaining time for progress dialog.

	Parameters:	
		byRef INT64 elapsed - the elapsed time in milliseconds
		byRef INT64 remaining - the remaining time in milliseconds

	Returns:
		BOOL success - true on success, false otherwise
	*/
	GetMilliseconds(byRef elapsed, byRef remaining)
	{
		return this._Error(DllCall(NumGet(this.vt, 12*A_PtrSize, "Ptr"), "Ptr", this.ptr, "Int64*", elapsed, "Int64*", remaining, "Int"))
	}

	/*
	Method: GetOperationStatus
	Gets operation status for progress dialog.

	Returns:
		UINT status - the dialog's status. You can compare it to the members of the PDOPSTATUS class.

	Remarks:
		- To get information about success and failure of this method, check the instance's Error object.
	*/
	GetOperationStatus()
	{
		local status
		this._Error(DllCall(NumGet(this.vt, 13*A_PtrSize, "Ptr"), "Ptr", this.ptr, "UInt*", status, "Int"))
		return status
	}
}