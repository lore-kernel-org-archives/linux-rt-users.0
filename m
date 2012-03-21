From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] rt-tests: Silence unused-but-set warning in
 rt-migrate-test
Date: Wed, 21 Mar 2012 12:45:00 -0400
Message-ID: <1332348300.23924.43.camel@gandalf.stny.rr.com>
References: <3343440fb02872debc8b49be5261aec530a205f3.1332270303.git.dvhart@linux.intel.com>
	  <b1216a51f76a038623057621a737d02a4ab441e4.1332270303.git.dvhart@linux.intel.com>
	  <1332338731.23924.40.camel@gandalf.stny.rr.com>
	  <4F69E940.9060808@linux.intel.com>
	  <CAONaPpHsCHG6QS+k9QRnQr7e1ZLEqFPHUf=-V6cw8bN+XWZPUA@mail.gmail.com>
	 <1332346704.23924.42.camel@gandalf.stny.rr.com>
	 <4F6A03A3.80104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31351 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab2CUQpB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 12:45:01 -0400
In-Reply-To: <4F6A03A3.80104@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-03-21 at 09:36 -0700, Darren Hart wrote:

> > So no, this patch isn't the fix. The real fix is to upgrade to the new
> > version of the code.
> > 
> 
> Of the compiler you mean?

No the rt-migrate-test. It doesn't have the logdev #ifdef making the
"end" variable unused.

-- Steve



