From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH] Fix the processing of optional options for cyclictest
Date: Fri, 27 Jun 2008 11:06:43 -0500
Message-ID: <48651013.2070704@gmail.com>
References: <520f0cf10806270110l5b3199ablc936c38f4bcf24eb@mail.gmail.com> <c384c5ea0806270734p73c68871k5dec8d1ad25afaff@mail.gmail.com> <Pine.LNX.4.58.0806271157001.20917@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Leon Woestenberg <leon.woestenberg@gmail.com>,
	John Kacur <jkacur@gmail.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36751 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757081AbYF0QHO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 27 Jun 2008 12:07:14 -0400
In-Reply-To: <Pine.LNX.4.58.0806271157001.20917@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Steven Rostedt wrote:
> 5B
>
> On Fri, 27 Jun 2008, Leon Woestenberg wrote:
>
>> Hello,
>>
>> I still found it strange that the RTWiki mentions "-t NUM" as if it
>> works, so the manual page of cyclictest and the wiki needs a review
>> too.
>
> It doesn't?
>
> Then again I must have an old version of cyclictest, because both -t5 and
> -t 5 work for me.
>
> -- Steve
>

You do. The current source in Thomas's git tree exhibits this
behavior, because of the way getopt() handles optional arguments.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhlEBMACgkQqA4JVb61b9eXdQCdG2PSWB40Os5VrT/wzttiUgFY
6fwAoIe+jW6q4AjIvmW1YQ8UMZHqFXoY
=Hxzp
-----END PGP SIGNATURE-----

