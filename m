From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers/cpuidle: coupled: remove unused define cpuidle_coupled_lock
Date: Wed, 27 Jan 2016 23:52:04 +0100
Message-ID: <1502553.xF2iE4QOmB@vostro.rjw.lan>
References: <1453922814-3173-1-git-send-email-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453922814-3173-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday, January 27, 2016 08:26:54 PM Anders Roxell wrote:
> This was found with the -RT patch enabled, but the fix should apply to
> non-RT also.
> 
> Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
> warning without this fix:
> ../drivers/cpuidle/coupled.c:122:21: warning: 'cpuidle_coupled_lock'
> defined but not used [-Wunused-variable]
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thanks!

Rafael
