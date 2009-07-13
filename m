From: Meha Mehta <mehtameha@gmail.com>
Subject: Re: Kernel Panic with preempt RT patch 2.6.29.5-rt21
Date: Mon, 13 Jul 2009 17:30:41 -0400
Message-ID: <af81d2bf0907131430u4251893eqfadfea094d3e64c@mail.gmail.com>
References: <af81d2bf0907130807w7af6aef0ha0210c263f93b01b@mail.gmail.com>
	 <af81d2bf0907130939vcad717ct64778d8f1be98ada@mail.gmail.com>
	 <4A5B90F4.6070200@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f184.google.com ([209.85.210.184]:40110 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282AbZGMVao convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Jul 2009 17:30:44 -0400
Received: by yxe14 with SMTP id 14so3582955yxe.33
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Jul 2009 14:30:42 -0700 (PDT)
In-Reply-To: <4A5B90F4.6070200@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks. It was a problem with creating initrd. I was creating initrd
with couple of ohci modules excluded and I guess that was creating
problem. Thanks for your help.

Meha.

On Mon, Jul 13, 2009 at 3:54 PM, Darren Hart<dvhltc@us.ibm.com> wrote:
> Meha Mehta wrote:
>>
>> Hi all,
>>
>> I am trying to boot Linux 2.6.29.5 with PREEMPT RT patch on x86
>> system. I have enabled all the configuration option required for
>> PREEMPT_RT.
>> I get kernel panic with message "Attempted to kill init!". Here is
>> panic output.
>>
>> ? panic 0x48/0xd1
>> ? do_exit + 0x5e/0x637
>> ? do_group_exit+0x5b/0x83
>> ? sys_exit_group+0xd/0x10
>> ? syscall_call+0x7/0xb
>>
>> I get same panic with 2.6.29.5-rt22 and 2.6.29.6-rt23.
>>
>> Has anybody tried 2.6.29.5-rt21 patch? What am I missing here? Any
>> suggestions?
>
> Most likely a configuration issue or a bad initrd. =A0Tell us a bit a=
bout
> which OS you're building on and what the messages were before the pan=
ic.
> =A0First guess is you may have failed to include the module for your =
root
> filesystem either in the initrd or as =3Dy in the kernel.
>
> --
> Darren Hart
> IBM Linux Technology Center
> Real-Time Linux Team
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
