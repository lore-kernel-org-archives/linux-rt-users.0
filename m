From: Tim Sander <tstone@vlsi.informatik.tu-darmstadt.de>
Subject: Re: Measuring timer interrupt latency
Date: Mon, 13 Apr 2009 12:56:59 +0200
Message-ID: <200904131256.59826.tstone@vlsi.informatik.tu-darmstadt.de>
References: <002901c9bc03$54aa23d0$3f52c70a@dlh.st.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
To: "'rt-users'" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx503.hrz.tu-darmstadt.de ([130.83.156.232]:50620 "EHLO
	lnx503.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752907AbZDMLFK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 Apr 2009 07:05:10 -0400
Received: from mailserver3.hrz.tu-darmstadt.de (lnx505.hrz.tu-darmstadt.de [130.83.156.234])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.13.8/HRZ/PMX) with ESMTP id n3DAv3jV021905
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Apr 2009 12:57:03 +0200
	(envelope-from tstone@vlsi.informatik.tu-darmstadt.de)
Received: from [213.157.27.17] (helo=IP-213157027017.dialin.heagmedianet.de)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tstone@vlsi.informatik.tu-darmstadt.de>)
	id 1LtJqZ-00059I-KT
	for linux-rt-users@vger.kernel.org; Mon, 13 Apr 2009 12:57:03 +0200
In-Reply-To: <002901c9bc03$54aa23d0$3f52c70a@dlh.st.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

HI Suresh
> Is there any test program which captures interrupt latency (for x86) ?
> I checked realfeel but it is user mode program and am not sure of its
> accuracy.
I've posted some code to this list on this 3.3.09 with the subject:
"Latency measurement module". Which does exactly that. ableit with the 
small problem that the TSC is not in sync on AMD SMP machines.

Regards
Tim
-- 
''=~('(?{'.('._@@[~'^'^-)./^').'"'.('}@@~-]@_^__'^'))-^~<.;;-}').',$/})')
