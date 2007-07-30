From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH -rt 7/9] introduce PICK_FUNCTION
Date: Mon, 30 Jul 2007 09:16:08 -0700
Message-ID: <1185812168.2636.30.camel@imap.mvista.com>
References: <20070730024534.369897977@mvista.com>
	 <20070730024720.690642602@mvista.com>  <1185788368.7197.2.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:23078 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966621AbXG3Q0c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 12:26:32 -0400
In-Reply-To: <1185788368.7197.2.camel@twins>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2007-07-30 at 11:39 +0200, Peter Zijlstra wrote:
> On Sun, 2007-07-29 at 19:45 -0700, Daniel Walker wrote:
> 
> > +#undef TYPE_EQUAL
> > +#define TYPE_EQUAL(var, type) \
> > +		__builtin_types_compatible_p(typeof(var), type *)
> > +
> 
> If you're going to touch this code, could you perhaps change TYPE_EQUAL
> to do as it says and read like so:
> 
> 	__builtin_types_compatible_p(typeof(var), type)
> 

Yeah that makes sense .. I'll add it to my tree ..

Daniel
