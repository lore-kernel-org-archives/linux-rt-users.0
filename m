From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in
 rt-migrate-test
Date: Wed, 21 Mar 2012 12:18:24 -0400
Message-ID: <1332346704.23924.42.camel@gandalf.stny.rr.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	 <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
	 <1332338731.23924.40.camel@gandalf.stny.rr.com>
	 <4F69E940.9060808@linux.intel.com>
	 <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:2920 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759404Ab2CUQS0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 12:18:26 -0400
In-Reply-To: <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-03-21 at 15:56 +0100, John Kacur wrote:
> >
> 
> Yup, shows up on my F16 machine too, with a slightly different gcc version.
> gcc --version
> gcc (GCC) 4.6.2 20111027 (Red Hat 4.6.2-1)

Egad! This is an old version. It still uses *gasp* logdev!

I have a new version that writes into ftrace, and doesn't use #ifdef,
but instead just looks to see if it is added to the kernel or not.

So no, this patch isn't the fix. The real fix is to upgrade to the new
version of the code.

-- Steve


