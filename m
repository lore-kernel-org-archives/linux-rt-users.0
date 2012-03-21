From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in
 rt-migrate-test
Date: Wed, 21 Mar 2012 12:51:42 -0400
Message-ID: <1332348702.23924.44.camel@gandalf.stny.rr.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	 <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
	 <1332338731.23924.40.camel@gandalf.stny.rr.com>
	 <4F69E940.9060808@linux.intel.com>
	 <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
	 <1332346704.23924.42.camel@gandalf.stny.rr.com>
	 <4F6A03A3.80104@linux.intel.com>
	 <CAONaPpH3VoiMw5tWFXu1nNDKMJu6AcWJDsoi5Bt2FdS145TC+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7536 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2CUQvn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 12:51:43 -0400
In-Reply-To: <CAONaPpH3VoiMw5tWFXu1nNDKMJu6AcWJDsoi5Bt2FdS145TC+Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-03-21 at 17:41 +0100, John Kacur wrote:

> > Of the compiler you mean?
> >
> 
> :) Yup, that's what he meant.

Um, no it wasn't.

-- Steve


>  Of course this is not a realistic option
> for many of us. Can you live with the stupid warning for now instead
> of cluttering the code with the annotations?
> 


