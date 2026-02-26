import { forwardRef } from "react";

interface EmailProps {
  onChange: (event: { target: { name: string; value: string } }) => void;
  name: string;
  message: string;
  label: string;
  required: boolean;
  value: string;
  disabled: boolean;
}

const EmailInput = forwardRef<HTMLInputElement, EmailProps>(({
  onChange,
  name,
  message,
  label,
  required,
  value,
  disabled
}, ref) => {
  return (
    <>
      <label htmlFor={name} className="block mb-2 text-sm font-medium text-gray-900 uppercase">
        {label}
        {required && <span className="text-red-500 ml-1">*</span>}
      </label>
      <input
        type="email"
        id={name}
        name={name}
        className="block w-full p-2.5 bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-slate-500 focus:border-slate-500 outline-none transition-all"
        placeholder={message}
        value={value}
        onChange={(e) => onChange({ target: { name: e.target.name, value: e.target.value } })}
        disabled={disabled}
        required={required}
        ref={ref}
      />
    </>
  );
});

EmailInput.displayName = "EmailInput";
export default EmailInput;