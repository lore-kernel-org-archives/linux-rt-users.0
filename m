Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C331FDA69
	for <linux-rt-users@vger.kernel.org>; Mon, 13 Jan 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764132; cv=none; b=gd64NM7wDyaMaJ4JNm7E64bChqfYDR+EIGI9hRxYmpILX/yLV6LqRjjMfJgzg6AZ78OTR+ziP8BsxyOrMxSSfRgCfx81gSW3/Ww0w2CC60LLI3DqgXIQpix5rBw7Dr5KHXUVggPTCLjKZ9Wyi+PXo+PXHQzDXw+s7Gw6UFuc9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764132; c=relaxed/simple;
	bh=9QhyYdYTwdLqLonlGHVzY37DoJKpHvqDu7eTztTLPhk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TeLaduDUxB09zlJh8SxnT2Ob6xBiHc9npTHJL0GWfQOZjs2/cB1es33gLQnbIAGQAVg6gfqTDrcoLOEyOVUvxqRecQc8gQ4BWIeLAbsq9mNtOtyKBZ1N8SucpYx/JvB5LCxlq25WdT7EVWRXNr+Md5d0QHFsTbsd3vFzhl8WSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b=U3gpqAJ0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=mista.tapas@gmx.net header.b="U3gpqAJ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736764117; x=1737368917; i=mista.tapas@gmx.net;
	bh=9QhyYdYTwdLqLonlGHVzY37DoJKpHvqDu7eTztTLPhk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=U3gpqAJ03iheKjSPCQMyL/wcyFk3XETTJ826Avfzjmu808jh4SyGU/eukSOX+azV
	 aU1W/XSyVDTtQS/YfmXyrtwUZLlRxZs0xCYXEZ2PT4NSub8wb5wWRwLrzjNxj0KpD
	 P0WGw3G4PII4ZLo6feluHtssKRa4G0PbYXW+QtVaCC9G3zhEURrSMse70/Y4w08ZN
	 d7Ru+rlAPZjj4x2Ck3ddX8ticnZl+RQS4id+O+YA145Aovma3n2qMMuB02S+JoqUD
	 gEv+ULVnwK7JG2MidyaRPsL9aqqBJCY62Qn2GGVBMio1U37O2aBEa/cLQAfzaMKWC
	 Mn6Wdus63CXgR37u0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mjj87-1t9jFW1mf5-00m0V6; Mon, 13
 Jan 2025 11:28:37 +0100
Message-ID: <96bedb76-556f-4a57-bb78-d2fd42efb25c@gmx.net>
Date: Mon, 13 Jan 2025 11:28:37 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Raspberry Pi 5 and PREEMPT_RT (6.13.0-rc3)
From: Florian Paul Schmidt <mista.tapas@gmx.net>
To: John Ogness <john.ogness@linutronix.de>,
 Leon Woestenberg <leon@sidebranch.com>
Cc: linux-rt-users@vger.kernel.org
References: <d445e582-4e49-4135-9d94-f52d72ec5df6@gmx.net>
 <84bjx6h2kd.fsf@jogness.linutronix.de>
 <cb569b76-e0ac-4063-9956-ab6307594d86@gmx.net>
 <CAMjhiJjpnP4Nr5YmgntPd43gndBXnh_DOjW_davDVG2fu0F4sQ@mail.gmail.com>
 <ecb3c326-9d5e-4a39-b9eb-5cc318596eb0@gmx.net>
 <84frlnsosm.fsf@jogness.linutronix.de>
 <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
Content-Language: en-US
In-Reply-To: <1ae1d4d7-4e16-4c9e-b432-5769a816375b@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zXBjG+WdSv7TldjOTusWq179+5PGOF1QvolWZ8krHkWz9ChQLGS
 otRxiQMK+Z1sE244HeqKjvqXvVacBiWiAoQW8ufaaxKyOnuEro5vIA7s7FwPg6JF3MW5ZDZ
 TBO+IuXq2N5VjgMmL8plFaiOyzI21jF7lWBxSLf1RjsdKFrUhPwt9xD/oVy9Ih3QC2xCwJ8
 /gaGE+ROOR/ixPvYkjArA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MNYiY1B4WSw=;VAXoD2dfKv6PmDmnHPXZy2rjK1i
 FRE7OzXHHywplM9YF/kkjbn15RXU1qcoQ5aRvnkSUnmEX1Q9/J0xr4jPidYgdwrGMGWNN1IST
 tX8X46EJc/Y8ZuHC6y7ttdTy7vxKkquvCxYLA3X4/aeRi185k6vVgE1DQf+KPUHmp7UZakL5J
 sqWB8hRav0LbI+m6iM6HWXcT9p2Doe8o5oehcFM7pjShpjwD1YyGKzrGhDlhUetC6RYW10Ys8
 eqvjV59lRvn8UpX6zI7VzEjIyg1g68kaAE9atOho+AsMrjLk0usae76+tuWNdi4+FKLEhGR8O
 RRzhKlLrn95zkThx6aeST1G99r+GF9rIcAcogMWddSKnAlOcQz9wc3rzmhVnCjENZ4ttEg+q0
 lGMTdXDW6GE49atk+BI4Tcdmgdtm7hFS7Ia98gTmpVMmn3Nlvq+71+ynrAfZu/2hWNfhqcu75
 2dO6CoLRXbzmiWQ90EgN8PW4zaoI3Bj+hlkWVXZjPYM0+cCCivsYiqWHj6GcHqzIENNFKMSTP
 qgRMXrP4P2AMlrfPriW86TVCiqdmNttR+tdeKwtxzMnzuqlmtNwtqCW9j0h7NPyBOaJ8HRis9
 J64EyX5rVJ9nfpazfDMMgdI98JxQwvVgiqnNj2kY3B0QIhidDk8Y4xzWMcLXOEygXc1OwKkDS
 jYz2GNUQcxMRLFbv78YeaY8cEHpvDlBZuvERJvZIsyH3YS7BNP/Qz+bqFK1mfmQl7+8dhZ6NF
 LAirSzmU86XhD5A7zsvQDpjBKDW7ktrTTMpc5NKsuyr336QrEHfs+xymu8mOYLFzVeU8cC3tJ
 HyBXShpm3ZhWXiDVl4StWcbOWYJxYYK3v6MxEt1ldfv43HRDB1GIponW4VRkQx5hMjGQagM1r
 J9KUo4or2yYSC15tRBHJbFD5UDxBnBUuhGpGX69f0bLFkoH2f7HPNaw2KUefUlLO6FIj5QImS
 uYlzcj5Ix8YLAH7CPZZNa63AmPq39jGJvuRPksFvBkVBwTtp087qg4lk23h0Tbeh4YC1yX+tn
 1wul0hBmlMs7pk4ug/OQ6FPr/QdiLrU/ud5+WBXN6QPpqXPIdQjy1sc2tq0eOY6eg5yUPR7GE
 1auK2nF7viu2BUIxqdAcROYQtuRcNd

On 1/13/2025 10:15 AM, Florian Paul Schmidt wrote:
[...]
> No, that is going to be the next thing I'll try. Sadly something's up
> with the generated patch script. The kernel directory resulting from
> running it is missing the top-level Kconfig. There's a hunk in the
> monsterpatch that deletes it:
>
> Index: linux-6.1.66-rt19-v8-16k/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-6.1.66-rt19-v8-16k.orig/Kconfig
> +++ /dev/null
> [...]
>
> Lines 246845 and following.
>
> Why? :)

Hmm, and also the provided .config is not really complete it seems.
After re-adding the Kconfig file make oldconfig asks a couple of questions=
.

And also it seems the kernel has to be built differently from the usual
raspberry pi kernels. Does it not support device tree overlays? The dtbs
target complained about missing makefiles..

Kind regards,
FPS

=2D-
https://blog.dfdx.eu

