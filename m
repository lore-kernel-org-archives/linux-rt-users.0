From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH-v3] tty: Use raw spin lock to protect the TTY read
 section
Date: Mon, 4 Feb 2013 16:33:33 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1302041616030.11905@ionos>
References: <CAMSQXEFFYqEZcJr5ig7fHgNd6Vfqh6GFZ_Md5OG=iRpDPWpTUw@mail.gmail.com> <1359376321-27274-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-serial@vger.kernel.org, RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <gregkh@linuxfoundation.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44429 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab3BDPdg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Feb 2013 10:33:36 -0500
In-Reply-To: <1359376321-27274-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 28 Jan 2013, Ivo Sieben wrote:
> @Thomas Gleixner & Steven Rostedt:
> Greg Kroah-Hartman responded to this patch: "And this really makes a
> difference? I'd like to hear the rt developers opinion of this."

In general the sleeping spinlocks overhead can be quite visible and
AFAICT the ntty read_lock only protects very short code pathes which
manipulate the read buffer and related data. So from an RT perspective
this lock can be a real spinlock even on RT.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx



