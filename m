From: Georgiewskiy Yuriy <bottleman@icf.org.ru>
Subject: Re: [ANNOUNCE] 3.0-rt3
Date: Sun, 24 Jul 2011 21:23:34 +0400 (MSD)
Message-ID: <alpine.DEB.2.02.1107242118510.14833@icf.org.ru>
References: <alpine.LFD.2.02.1107241223560.2702@ionos>  <4E2C2ED6.4040904@gmail.com>  <alpine.LFD.2.02.1107241807390.3136@ionos> <1311525756.2276.6.camel@box>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1051000339-55303083-1311528214=:14833"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Maarten Lankhorst <m.b.lankhorst@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhart@linux.intel.com>
To: hermann <brummer-@web.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311525756.2276.6.camel@box>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1051000339-55303083-1311528214=:14833
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On 2011-07-24 18:42 +0200, hermann wrote Thomas Gleixner:

Hi, I confirm it too - random freezes during normal work, no load, no logs too, sometimes 
while starting X, sometimes after X started and worked, also randome freezes 
while suspend-resume то ram aka ACPI S3 state.

h> schrieb Thomas Gleixner:
h>
h>> Dear RT Folks,
h>> 
h>> I'm pleased to announce the 3.0-rt3 release.
h>> 
h>> Changes versus 3.0-rt2:
h>> 
h>>   * Fix earlyprintk really
h>> 
h>
h>Hi
h>
h>I still have some trouble with rt1 - rt3. 
h>During boot, the kernel is absolutely silent, sometimes it hangs on boot,
h>sometimes it hangs on login, sometimes it freeze without any known reason 
h>during session (no heavy load or some thing like that).
h>I cant find any meaningful log, so I just can report it as it is here.
h>rc7-rt0 works very well here, I build 3.0-rt1 - rt3 with the same config 
h>then rt0.
h>
h>regards
h>hermann
h>
h>--
h>To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
h>the body of a message to majordomo@vger.kernel.org
h>More majordomo info at  http://vger.kernel.org/majordomo-info.html
h>

C уважением                       With Best Regards
Георгиевский Юрий.                Georgiewskiy Yuriy
+7 4872 711666                    +7 4872 711666
факс +7 4872 711143               fax +7 4872 711143
Компания ООО "Ай Ти Сервис"       IT Service Ltd
http://nkoort.ru                  http://nkoort.ru
JID: GHhost@icf.org.ru            JID: GHhost@icf.org.ru
YG129-RIPE                        YG129-RIPE
---1051000339-55303083-1311528214=:14833--
