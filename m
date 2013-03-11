From: David Sommerseth <davids@redhat.com>
Subject: Re: RFC: patch to trigger thread stats output from cyclictest with
 SIGHUP
Date: Mon, 11 Mar 2013 17:54:05 +0100
Message-ID: <513E0C2D.1050401@redhat.com>
References: <20130311111607.587cda32@riff.lan> <CAP=VYLrV7QbA_+L66WVGSYoJaF-+sh8uyw0boq8hDCkF0xrQtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab3CKQyA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Mar 2013 12:54:00 -0400
In-Reply-To: <CAP=VYLrV7QbA_+L66WVGSYoJaF-+sh8uyw0boq8hDCkF0xrQtw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/03/13 17:25, Paul Gortmaker wrote:
> On Mon, Mar 11, 2013 at 12:16 PM, Clark Williams 
> <williams@redhat.com> wrote:
>> John,
>> 
>> Steven suggested a feature for cyclictest that I'd actually been
>>  whining about (internally anyway). During long rteval runs 
>> there's really no feedback available if you want to know how the 
>> run is progressing. Steven suggested sending SIGHUP and dumping 
>> the current state. Below is a patch that seems to work for 
>> cyclictest; just wanted to get some feedback on whether this 
>> would be acceptable behaviour.
> 
> Is USR1 already in use for something?  That would be consistent 
> with how things like dd use USR1 signal - to report interim stats.
> 
> P.

+1 ... I was just about to say exactly the same.


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE+DCsACgkQIIWEatLf4Hc4lACdHs1Cuv4u1tJxkoDOfmKXSCiL
s/gAn1XHwrcn2jiNF2Q+0EC22aj+j1Ah
=nME1
-----END PGP SIGNATURE-----
