From: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Subject: Re: [PATCH] kexec: reenable HPET before kexec
Date: Tue, 21 Aug 2007 01:10:50 +0400
Message-ID: <46CA035A.5050202@ru.mvista.com>
References: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
To: Konstantin Baydarov <kbaidarov@ru.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761987AbXHTVKy@vger.kernel.org>
In-Reply-To: <20070820205530.1ffd5876@windmill.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Konstantin Baydarov wrote:
> Hi, I've faced problem:
> I have two x86_64 kernels with HPET enabled:
> kernel 1 - with PM enabled,
> kernel 2 - with PM disabled.
>   
Forgot to say that it's RT kernel, version is 2.6.23-rc2-rt2.
