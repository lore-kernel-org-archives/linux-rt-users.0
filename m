From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.18.7-rt1
Date: Mon, 16 Feb 2015 15:21:04 -0500
Message-ID: <20150216152104.658afb62@gandalf.local.home>
References: <20150216111822.GA21649@linutronix.de>
	<20150216201239.GC4243@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/Q+g/g.SHAb4rH5ey5iuSoK1"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:44639 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750999AbbBPUVI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Feb 2015 15:21:08 -0500
In-Reply-To: <20150216201239.GC4243@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--MP_/Q+g/g.SHAb4rH5ey5iuSoK1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 16 Feb 2015 21:12:40 +0100
Richard Cochran <richardcochran@gmail.com> wrote:

> On Mon, Feb 16, 2015 at 12:18:22PM +0100, Sebastian Andrzej Siewior wrote:
> >       - CPU hotplug works in general. Steven's test script however
> >         deadlocks usually on the second invocation.
> 
> Where can I find Steve's hotplug test script?

Here, I posted it before. Hmm, I wonder if we should post it on some
web site. I could add it to my own.

/me does that...

OK, it's now here too:

 http://rostedt.homelinux.com/code/stress-cpu-hotplug

-- Steve

--MP_/Q+g/g.SHAb4rH5ey5iuSoK1
Content-Type: application/octet-stream; name=stress-cpu-hotplug
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=stress-cpu-hotplug

IyEvYmluL2Jhc2gKCk1BWENQVVM9MTIKCiMgZmluZCBjcHVzCgpDUFVTPWBscyAtZCAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHVbMS05XSpgCk5SPWBlY2hvICRDUFVTIHwgd2MgLXdgCgpsZXQg
eD0wCmZvciBjcHUgaW4gJENQVVM7IGRvCiAgICBmaWxlPSRjcHUvb25saW5lCiAgICBDUFVPTkxJ
TkVbJHhdPSRmaWxlCiAgICBFTkJbJHhdPWBjYXQgJGZpbGVgCiAgICBDUFVbJHhdPWBiYXNlbmFt
ZSAkY3B1YAogICAgbGV0IHg9JHgrMQpkb25lCgpsZXQgTUFYQ05UPSR4CgpNU0tDTlQ9JE1BWENO
VAoKaWYgWyAkTUFYQ05UIC1ndCAkTUFYQ1BVUyBdOyB0aGVuCiAgICBNU0tDTlQ9JE1BWENQVVMK
ZmkKCmxldCBNU0tDTlQ9MioqJE1TS0NOVAoKaG90cGx1ZygpIHsKICAgIE1TSz0kMQogICAgRUNI
Tz0iJE1TSyIKICAgIENNRD0iIgogICAgeD0wCiAgICB3aGlsZSBbICRNU0sgLWd0IDAgXTsgZG8K
CWxldCBiaXQ9JE1TSycmJzEKCWlmIFsgJGJpdCAtZXEgMSBdOyB0aGVuCgkgICAgaWYgWyAke0VO
QlskeF19IC1lcSAxIF07IHRoZW4KCQljbWQ9ImRpc2FibGluZyIKCQlFTkJbJHhdPTAKCQludW09
MAoJICAgIGVsc2UKCQljbWQ9ImVuYWJsaW5nIgoJCUVOQlskeF09MQoJCW51bT0xCgkgICAgZmkK
CSAgICBDTUQ9IiRDTUQgZWNobyAkbnVtID4gJHtDUFVPTkxJTkVbJHhdfTsiCgkgICAgRUNITz0i
JEVDSE8gJGNtZCAke0NQVVskeF19IgoJZmkKCWxldCB4PSR4KzEKCWxldCBNU0s9JE1TSyc+Picx
CiAgICBkb25lCiAgICBlY2hvICRFQ0hPCiAgICBldmFsICRDTUQKfQoKbGV0IE1TS0NOVD0kTVNL
Q05ULTEKZm9yIGkgaW4gYHNlcSAkTVNLQ05UYDsgZG8KICAgIGhvdHBsdWcgJGkKZG9uZQpmb3Ig
aSBpbiBgc2VxICRNU0tDTlRgOyBkbwogICAgaG90cGx1ZyAkaQpkb25lCgpleGl0IDAK

--MP_/Q+g/g.SHAb4rH5ey5iuSoK1--
