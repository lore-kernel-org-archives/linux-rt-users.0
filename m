From: Ng Oon-Ee <ngoonee@gmail.com>
Subject: Re: Nvidia patches for 2.6.33-rt?
Date: Thu, 4 Mar 2010 11:20:05 +0800
Message-ID: <4ccf65461003031920x4384ab8cg2b89ba890009ea8f@mail.gmail.com>
References: <4ccf65461003020059h272bccfay1c9200906995a9e2@mail.gmail.com>
	 <loom.20100303T130614-97@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61702 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab0CDDUG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 3 Mar 2010 22:20:06 -0500
Received: by pwj8 with SMTP id 8so1363817pwj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Mar 2010 19:20:05 -0800 (PST)
In-Reply-To: <loom.20100303T130614-97@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 3, 2010 at 8:16 PM, Jonathan Schmidt <j.schmidt@archlinux.u=
s> wrote:
> Ng Oon-Ee <ngoonee <at> gmail.com> writes:
>
>>
>> Hi all, has anyone patched the nvidia binary installer for 2.6.33-rt=
?
>> Would like to have a look. I use nvidia-beta myself, but from previo=
us
>> -rt kernels I know I can figure out the patch from that given the
>> patch for any other nvidia installer.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo <at> vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
>
>
> I have absolutely no idea if this is the best way to handle the semap=
hore_init
> issue, I don't even know what a semaphore is, but I submitted a simpl=
e patch at
> http://www.nvnews.net/vbulletin/showthread.php?t=3D148509 anyway. It =
builds and
> appears to be working, but I'd like some verification that sema_init(=
mutex,1) is
> a valid substitute for semaphore_init(mutex).
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Works here as well (for nvidia 195.36.08). Many thanks, Jonathan. Such
a simple patch compared to the previous one for 2.6.31-rt.

Would still appreciate information from someone who knows the code
about sema_init(mutex,1) though =3D).
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
