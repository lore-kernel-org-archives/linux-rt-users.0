From: "Remy Bohmer" <l.pinguin@gmail.com>
Subject: Re: PI mutex support on ARM
Date: Sun, 8 Jul 2007 22:17:40 +0200
Message-ID: <3efb10970707081317k22de079dr9a5cad6a42cf5b3b@mail.gmail.com>
References: <3efb10970707080124i7a9323c5o9257b4adcb2ac493@mail.gmail.com>
	 <20070708095841.GA4601@elte.hu>
Reply-To: linux@bohmer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:28196 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792AbXGHURl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Jul 2007 16:17:41 -0400
Received: by py-out-1112.google.com with SMTP id d32so1304569pye
        for <linux-rt-users@vger.kernel.org>; Sun, 08 Jul 2007 13:17:40 -0700 (PDT)
In-Reply-To: <20070708095841.GA4601@elte.hu>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello Ingo,

> patch format problem: never diff the asm/ files, diff the asm-arm/ files.
Yeah, of course, I know, I believe I made a real mess of this one ...

> is it safe to do a get_user() with irqs off?
rhetorical question ;-))
I was wondering, Is it safe to use a normal spinlock here, like this?

------- 8-< -------------
	spin_lock(&futex_lock);

	err = get_user(uval, uaddr);
	if ((!err) && (uval == oldval))
		err = put_user(newval, uaddr);

	spin_unlock(&futex_lock);
------- 8-< -------------

> is this method of atomic ops SMP-safe?
another rhetorical question ;-))
Nope, I already knew that, that why I mentioned that it probably only
worked on UP...

Remy
