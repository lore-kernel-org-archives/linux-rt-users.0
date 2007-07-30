From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -rt 7/9] introduce PICK_FUNCTION
Date: Mon, 30 Jul 2007 11:39:28 +0200
Message-ID: <1185788368.7197.2.camel@twins>
References: <20070730024534.369897977@mvista.com>
	 <20070730024720.690642602@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:33129 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939234AbXG3Jjf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 05:39:35 -0400
In-Reply-To: <20070730024720.690642602@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2007-07-29 at 19:45 -0700, Daniel Walker wrote:

> +#undef TYPE_EQUAL
> +#define TYPE_EQUAL(var, type) \
> +		__builtin_types_compatible_p(typeof(var), type *)
> +

If you're going to touch this code, could you perhaps change TYPE_EQUAL
to do as it says and read like so:

	__builtin_types_compatible_p(typeof(var), type)
