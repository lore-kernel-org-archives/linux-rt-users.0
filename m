From: Michael <dev@michaeljones.de>
Subject: Re: [PATCH 6/6] cyclictest: Add long option --laptop to preserve
 battery power
Date: Mon, 18 Aug 2014 22:29:13 +0200
Message-ID: <53F26219.2000302@michaeljones.de>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com> <1408033090-24866-7-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:60935 "HELO
	gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751903AbaHRU3V (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Aug 2014 16:29:21 -0400
In-Reply-To: <1408033090-24866-7-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/14/2014 06:18 PM, John Kacur wrote:
> Some people running cyclictest on laptops don't want to automatically
> take advantage of the trick that prevents the power management to
> transistion to high cstates, since it eats up their battery power.

s/transistion/transition/
