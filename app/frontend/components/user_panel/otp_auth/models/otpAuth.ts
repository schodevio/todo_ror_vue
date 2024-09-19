export class OTPAuthModel {
  current_password: string = ''
  otp_required_for_login: boolean = false
  otp_backup_codes: string[] = []
  otp_secret_key: string
  otp_code: string = ''

  qrcode_svg?: string

  links: {
    otp_auth_path: string
  }

  constructor(data: Partial<OTPAuthModel> = {}) {
    Object.assign(this, data)
  }

  get enableParams() {
    return {
      otp_code: this.otp_code,
      current_password: this.current_password
    }
  }

  get verifyParams() {
    return {
      otp_code: this.otp_code
    }
  }

  get disableParams() {
    return {
      current_password: this.current_password
    }
  }
}
