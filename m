From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance  tracking
Date: Tue, 23 Oct 2012 12:55:56 -0700
Message-ID: <5086F64C.20802@am.sony.com>
References: <1802256036.5241288.1351020331171.JavaMail.root@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Bhavesh Davda <bhavesh@vmware.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:37207 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756884Ab2JWTz5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 15:55:57 -0400
In-Reply-To: <1802256036.5241288.1351020331171.JavaMail.root@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/23/12 12:25, John Kacur wrote:
> 

< snip >

> Let's not overdo it here, I've actually already added these patches
> in my private repo. I only want to hear if there are functional
> problems. I'm wondering if this is fine with histograms by default or
> if we want to protect it with an option? Or do we need to add
> something to make it easy to filter out?

OK.  I'll apply the patches, test the result, and do a review.

-Frank

