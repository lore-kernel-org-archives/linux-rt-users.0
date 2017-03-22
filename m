From: Lionel DEBIEVE <lionel.debieve@st.com>
Subject: Re: [PATCH RT] tty: serial: st-asc: Make the locking RT aware
Date: Wed, 22 Mar 2017 08:43:50 +0000
Message-ID: <99a6d117-4998-fe37-5e32-ef773597e8e9@st.com>
References: <1490112340-29772-1-git-send-email-lionel.debieve@st.com>
 <20170321144437.569440c2@vmware.local.home>
 <alpine.DEB.2.20.1703211950040.3776@nanos>
 <20170321161533.44c4df87@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        Patrice CHOTARD <patrice.chotard@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36883 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758804AbdCVIoK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 04:44:10 -0400
In-Reply-To: <20170321161533.44c4df87@vmware.local.home>
Content-Language: en-US
Content-ID: <3A1AF79AFB3F6A4F903795CF30682228@st.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just to agree with Thomas.

Do you want me to resend the patch without RT tag?

BR,
Lionel


On 03/21/2017 09:15 PM, Steven Rostedt wrote:
> On Tue, 21 Mar 2017 19:51:47 +0100 (CET)
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Tue, 21 Mar 2017, Steven Rostedt wrote:
>>>>   	/*
>>>>   	 * Disable interrupts so we don't get the IRQ line
>>>> bouncing
>>> I'm nervous about the above comment, which in full is:
>>>
>>> 	/*
>>> 	 * Disable interrupts so we don't get the IRQ line bouncing
>>> 	 * up and down while interrupts are disabled.
>>> 	 */
>>>
>>> I'm not sure if disabling interrupts helps on an SMP system. This
>>> patch does change what happens when port->sysrq is set. But I'm not
>>> sure we care.
>> It disables interrupts at the device level which obviously helps
>> whether on SMP or not.
>>
> OK, so this has nothing to do with the local_irq_save() that is being
> removed, which would be fine then.
>
>
> -- Steve
>
