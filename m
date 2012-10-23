From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: whitespace cleanup
Date: Mon, 22 Oct 2012 18:12:58 -0700
Message-ID: <5085EF1A.7060503@am.sony.com>
References: <F285BDD9-9A4A-4B58-B69F-90F18B9D7B4D@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:8704
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756293Ab2JWBNF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2012 21:13:05 -0400
In-Reply-To: <F285BDD9-9A4A-4B58-B69F-90F18B9D7B4D@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/16/12 09:39, Bhavesh Davda wrote:
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Cosmetic whitespace cleanup
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>

>From checkpatch:


ERROR: code indent should use tabs where possible
#161: FILE: src/cyclictest/cyclictest.c:1419:
+                        printf(fmt, index, stat->tid, par->prio,$

WARNING: please, no spaces at the start of a line
#161: FILE: src/cyclictest/cyclictest.c:1419:
+                        printf(fmt, index, stat->tid, par->prio,$

total: 1 errors, 1 warnings, 140 lines checked


You did not add leading white space - it was already there and your
noble effort to remove the trailing white space led to this line
getting caught by checkpatch.  Anyway, it is a good practice to
be checkpatch clean, even it rt-tests are not the linux kernel.

-Frank

