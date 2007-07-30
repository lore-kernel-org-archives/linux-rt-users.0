From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: Re: BUG: scheduling while atomic: stress
Date: Mon, 30 Jul 2007 05:37:17 +0000
Message-ID: <34ac6d890707292237t591af349i5a0144afda98d091@mail.gmail.com>
References: <34ac6d890707260635m1d1165d1m5e01b7faa925e86c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:44593 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbXG3FhS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Jul 2007 01:37:18 -0400
Received: by an-out-0708.google.com with SMTP id d31so259720and
        for <linux-rt-users@vger.kernel.org>; Sun, 29 Jul 2007 22:37:17 -0700 (PDT)
In-Reply-To: <34ac6d890707260635m1d1165d1m5e01b7faa925e86c@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> ./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s
The problem seems to be caused by the vm part of the stress code.
When I run this with vm = 1 it works fine , when the vm thread is
increased it causes the problem.
The thread does sync

while (1){
   sync ();
 }

Anyone got any suggestions.
Thanks in advance

Regards
Giri
