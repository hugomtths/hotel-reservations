import { forwardRef } from "react";
import styles from "./Cpf.module.css";

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
    <div className={styles.container}>
      <label htmlFor={name} className={styles.label}>
        {label}
        {required && <span className={styles.required}>*</span>}
      </label>
      <input
        type="text"
        id={name}
        name={name}
        className={styles.input}
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

export default CpfInput;