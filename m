From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 11 Jun 2015 14:38:56 +0200
Message-ID: <20150611123856.GH16115@linutronix.de>
References: <20150519213923.GA26363@linutronix.de>
 <20150526083449.5357059b@sluggy>
 <20150526093832.558e2e46@gandalf.local.home>
 <20150526084802.2cfd055b@sluggy>
 <20150526111924.20836deb@gandalf.local.home>
 <20150526104343.51fad474@sluggy>
 <5564CC80.3080101@localhost>
 <5567C741.5010007@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56364 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbbFKMi6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 08:38:58 -0400
Content-Disposition: inline
In-Reply-To: <5567C741.5010007@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Fernando Lopez-Lezcano | 2015-05-28 18:56:17 [-0700]:

>On 05/26/2015 12:41 PM, Fernando Lopez-Lezcano wrote:
>Oh well. Second time the machine hangs in two days in the same way
>(otherwise very stable running 3.18.x-rty)
http://marc.info/?l=3Dlinux-rt-users&m=3D143402285006570&w=3D2

In future
>May 28 18:49:21 localhost kernel: Call Trace:
>May 28 18:49:21 localhost kernel: [<ffffffff811b8d8f>]
>__remove_mapping+0x12f/0x1a0
>May 28 18:49:21 localhost kernel: [<ffffffff811bba3f>]
>shrink_page_list+0x5ef/0xc30
>May 28 18:49:21 localhost kernel: [<ffffffff811bc709>]
>shrink_inactive_list+0x1e9/0x630

Please make sure you client does not end the line for you. It is hard t=
o
read. And I may not want to=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
