From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] cyclictest: white space cleanup
Date: Mon, 28 Jan 2013 18:13:18 -0800
Message-ID: <5107303E.3010208@am.sony.com>
References: <51072F6A.1050105@am.sony.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "jkacur@redhat.com" <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:52338
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751958Ab3A2CNY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jan 2013 21:13:24 -0500
In-Reply-To: <51072F6A.1050105@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/28/13 18:09, Frank Rowand wrote:
> Clean up cyclictest formatting:
>   Change leading spaces to tabs.
>   Align function parameters.
>   Place type of function on same line as function name.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  src/cyclictest/cyclictest.c |   43 	21 +	22 -	0 !
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 

< snip >

The motivation of the white space clean up is so that future
patches will not add white space damage.  Many editors will
automatically copy the bad white space if a line immediately
following is added.

I tried to not get carried away with other formatting clean
up.  The alignment of function parameters was only a few
locations and seemed in the spirit of white space clean up.

The "type of function name" fix was getting carried away, but
there was only one instance so I don't feel too guilty.

-Frank


