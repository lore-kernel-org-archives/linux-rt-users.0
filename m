From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Changing checksums of RT patches
Date: Wed, 15 Feb 2017 18:15:23 +0100
Message-ID: <20170215171522.3x2tnlbu3gazub46@linutronix.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
 <20170214135738.366f21e5@gandalf.local.home>
 <0bf7c1fd-ab6e-75a3-a04b-158b6e2c1a8b@gmx.de>
 <20170215135215.r7osipapnicj3pw3@linutronix.de>
 <78d99832-db0e-7da5-15c4-fc3fa18d7cbd@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Dominic =?utf-8?B?U2FjcsOp?= <dominic.sacre@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:48151 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbdBORPZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 12:15:25 -0500
Content-Disposition: inline
In-Reply-To: <78d99832-db0e-7da5-15c4-fc3fa18d7cbd@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-15 15:50:48 [+0100], Dominic Sacré wrote:
> However, as far as I can see, the only mirror that's actually defined in
> OpenEmbedded is www.kernel.org. I could try to add cdn.kernel.org there,
> but I don't really know how exactly OpenEmbedded handles mirror servers,
> and what the policies are.

please replace instead of add
	https://kernel.org/introducing-fastly-cdn.html

so unless you (OpenEmbedded) wants to avoid fastly/cdn I don't see a
reason why there should be a policy against it :)
 
> Dominic

Sebastian
