From: Claus Gindhart <claus.gindhart@kontron.com>
Subject: Re: Hard lockup with 2.6.24.7-rt26 on x86
Date: Wed, 4 Feb 2009 13:31:37 +0100
Message-ID: <200902041331.37447.claus.gindhart@kontron.com>
References: <37144.1233608136@vtxmail.ch> <902d99b50902040046u3257591fxe29cef4e62315b1a@mail.gmail.com> <3efb10970902040356y46cb304bi2855769398d16439@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Denis Borisevich <dennisfen@gmail.com>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kontron-modular.com ([213.179.130.140]:30648 "EHLO
	mail.kontron-modular.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbZBDMbf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Feb 2009 07:31:35 -0500
In-Reply-To: <3efb10970902040356y46cb304bi2855769398d16439@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

On Wednesday 04 February 2009 12:56:26 pm Remy Bohmer wrote:
> Hello Denis,
>
> Please keep the mailinglist on the CC.
>
> Kind Regards,
>
> Remy
>
> 2009/2/4 Denis Borisevich <dennisfen@gmail.com>:
> > 2009/2/3 Remy Bohmer <linux@bohmer.net>:
> >> In noticed some hangups too while using 2.6.24.7-rt26, while
> >> 2.6.24.7-rt20 was running fine.
> >> I can reproduce it here on an ARM11 core, when
> >> CONFIG_DEBUG_LOCKING_API_SELFTESTS is set the system hangs during boot
> >> on rt26, while it boots properly on rt20. So, there is a regression
> >> here.
> >
> > I second that. With CONFIG_DEBUG_LOCKING_API_SELFTEST system hangs on
> > boot with -rt26.
> >
> > --
> > Denis
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

For your info:
i tried to reproduce this with 2.6.24.7-rt21, and i cant reproduce the problem 
here.



-- 
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com
