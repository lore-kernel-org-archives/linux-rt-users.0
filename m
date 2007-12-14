From: Darren Hart <dvhltc@linux.vnet.ibm.com>
Subject: 2.6.24-rc2-rt1 build failure: mod_unreg_security
Date: Thu, 13 Dec 2007 19:18:44 -0800
Message-ID: <200712131918.44236.dvhltc@linux.vnet.ibm.com>
Reply-To: Darren Hart <dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "lkml, " <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38295 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXLNDSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Dec 2007 22:18:48 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

security/realcaps.c still uses mod_unreg_security and=20
unregister_security to try and unregister the realtime capabilities=20
from LSM.  Those functions appear to have been removed from=20
security/security.c, so the build fails with:

security/realcap.c: In function =E2=80=98realtime_exit=E2=80=99:
security/realcap.c:129: error: implicit declaration of=20
function =E2=80=98mod_unreg_security=E2=80=99
security/realcap.c:133: error: implicit declaration of=20
function =E2=80=98unregister_security=E2=80=99
=E2=80=98mod_unreg_security=E2=80=99 only exists in the one place and i=
n the lsm.tmpl

I compared the security.c of 2.6.23.9-rt12 and it still has the two=20
missing functions.  Was there a change in how features are unregistered=
=20
from LSM that was missed for the realcaps.c file perhaps?

I commented out the unreg calls to try and build, it completed, but the=
=20
realcap.ko had several undefined symbols.

Kernel: arch/x86/boot/bzImage is ready  (#1)
ERROR: "cap_netlink_send" [security/realcap.ko] undefined!
ERROR: "cap_task_reparent_to_init" [security/realcap.ko] undefined!
ERROR: "cap_task_post_setuid" [security/realcap.ko] undefined!
ERROR: "cap_bprm_secureexec" [security/realcap.ko] undefined!
ERROR: "cap_bprm_set_security" [security/realcap.ko] undefined!
ERROR: "cap_vm_enough_memory" [security/realcap.ko] undefined!
ERROR: "cap_syslog" [security/realcap.ko] undefined!
ERROR: "cap_capable" [security/realcap.ko] undefined!
ERROR: "cap_capset_set" [security/realcap.ko] undefined!
ERROR: "cap_capset_check" [security/realcap.ko] undefined!
ERROR: "cap_capget" [security/realcap.ko] undefined!
ERROR: "cap_ptrace" [security/realcap.ko] undefined!
ERROR: "cap_bprm_apply_creds" [security/realcap.ko] undefined!
ERROR: "mod_reg_security" [security/realcap.ko] undefined!
ERROR: "register_security" [security/realcap.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

Checking the config I see this is marked as obsolete, so maybe we don't=
=20
care all that much - but if it wasn't just removed, I suspect we still=20
want it to build?

Thanks,

--=20
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
