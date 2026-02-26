import { forwardRef } from "react";

interface CpfProps {
  onChange: (event: { target: { name: string; value: string } }) => void;
  name: string;
  message: string;
  label: string;
  required: boolean;
  value: string;
  disabled: boolean;
}

const CpfInput = forwardRef<HTMLInputElement, CpfProps>(({
  onChange, name, message, label, required, value, disabled
}, ref) => {
  const maskCPF = (v: string) => {
    v = v.replace(/\D/g, "");
    if (v.length <= 11) {
      v = v.replace(/(\d{3})(\d)/, "$1.$2");
      v = v.replace(/(\d{3})(\d)/, "$1.$2");
      v = v.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
    }
    return v.slice(0, 14);
  };

  return (
    <div className="w-full">
      <label htmlFor={name} className="block mb-2 text-sm font-medium text-gray-900 uppercase">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <input
        type="text"
        id={name}
        name={name}
        className="block w-full p-2.5 bg-white border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-slate-500 focus:border-slate-500 outline-none transition-all"
        placeholder={message}
        value={value}
        onChange={(e) => onChange({ target: { name, value: maskCPF(e.target.value) } })}
        disabled={disabled}
        required={required}
        ref={ref}
      />
    </div>
  );
});

CpfInput.displayName = "CpfInput";
export default CpfInput;