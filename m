From: Jeremy Jongepier <autostatic@gmail.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Thu, 14 Apr 2011 09:02:55 +0200
Message-ID: <4DA69C1F.8010908@autostatic.com>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>	<497D1168CB2F407F9005845B39FEF144@e1705>	<alpine.LFD.2.00.1104111806021.4501@localhost6.localdomain6>	<BANLkTi=6UnfiOwwdwgJvW0kZyJ7OoE0dpg@mail.gmail.com>	<4DA32E16.8090807@osadl.org>	<alpine.LFD.2.00.1104111846140.6190@localhost6.localdomain6>	<369290E6B58D4A3BAC211B6A4BB73E0B@e1705> <BANLkTinKyw0d56USqVwJgVCsehpyVdMHVw@mail.gmail.com> <4DA5F178.4080705@autostatic.com> <4DA633DC.8060800@gmail.com>
Reply-To: jeremy@autostatic.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62150 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab1DNHDB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Apr 2011 03:03:01 -0400
Received: by fxm17 with SMTP id 17so978908fxm.19
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Apr 2011 00:03:00 -0700 (PDT)
In-Reply-To: <4DA633DC.8060800@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/14/2011 01:38 AM, Niccol=F2 Belli wrote:
> Il 13/04/2011 20:54, Jeremy Jongepier ha scritto:
>> 2.6.39 will integrate another very important part of the real-time
>> patchset though:
>> http://lists.linuxaudio.org/pipermail/linux-audio-dev/2011-March/030=
782.html
>
> "we sould start testing it during the rc cycle, i think.
> (there will not be too many people turning force threaded handler on)
>
> i will try to write up somthing about kernel config and boot paramete=
rs
> once i have a kernel running in my kvm later this week."
>
> I didn't find the kernel config and the boot parameters to test it. D=
o
> you know which ones should I set?
>
> Cheers,
> Darkbasic

You could check the latest -lowlatency kernel available for Ubuntu=20
Natty: https://launchpad.net/~abogani/+archive/snmp++/+packages
It contains a config that has force threaded handler enabled.

Best,

Jeremy

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
