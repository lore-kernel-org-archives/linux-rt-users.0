From: =?UTF-8?Q?Dominic_Sacr=c3=a9?= <dominic.sacre@gmx.de>
Subject: Re: Changing checksums of RT patches
Date: Wed, 15 Feb 2017 15:50:48 +0100
Message-ID: <78d99832-db0e-7da5-15c4-fc3fa18d7cbd@gmx.de>
References: <12e5d51b-8589-d9ba-90cd-d00688e8602d@gmx.de>
 <20170210185433.h35nynmmeu5toml6@linutronix.de>
 <812bef1a-a86e-15b6-b77c-6455832c8790@gmx.de>
 <548e1359-5539-4a7c-e9ca-44817ffa69b6@gmx.de>
 <20170214091829.12273157@gandalf.local.home>
 <ea5ff7b5-77d2-754d-b7c2-6c9f9c3d7b90@gmx.de>
 <20170214135738.366f21e5@gandalf.local.home>
 <0bf7c1fd-ab6e-75a3-a04b-158b6e2c1a8b@gmx.de>
 <20170215135215.r7osipapnicj3pw3@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:58530 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbdBOOw5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Feb 2017 09:52:57 -0500
In-Reply-To: <20170215135215.r7osipapnicj3pw3@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-02-15 14:52, Sebastian Andrzej Siewior wrote:
> please also consider www.kernel.org => cdn.kernel.org

Actually, OpenEmbedded globally defines a placeholder
${KERNELORG_MIRROR}, so I should probably use that, and not hardcode the
server in the RT-kernel recipe at all.

However, as far as I can see, the only mirror that's actually defined in
OpenEmbedded is www.kernel.org. I could try to add cdn.kernel.org there,
but I don't really know how exactly OpenEmbedded handles mirror servers,
and what the policies are.


Dominic
