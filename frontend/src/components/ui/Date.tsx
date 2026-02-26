import { forwardRef } from "react";

interface DateProps {
  onChange: (event: { target: { name: string; value: string } }) => void;
  name: string;
  message: string;
  label: string;
  required: boolean;
  value: string;
  disabled: boolean;
}

const DateInput = forwardRef<HTMLInputElement, DateProps>(({
  onChange, name, label, required, value, disabled
}, ref) => {
  return (
    <div className="w-full">
      <label htmlFor={name} className="block mb-2 text-sm font-medium text-gray-900 uppercase">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <input
        type="date"
        id={name}
        name={name}
        className="block w-full p-2.5 bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-slate-500 focus:border-slate-500 outline-none transition-all"
        value={value}
        onChange={(e) => onChange({ target: { name: e.target.name, value: e.target.value } })}
        disabled={disabled}
        required={required}
        ref={ref}
      />
    </div>
  );
});

DateInput.displayName = "DateInput";
export default DateInput;