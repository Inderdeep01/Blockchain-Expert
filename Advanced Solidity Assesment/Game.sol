pragma solidity >=0.4.22 <=0.8.17;

abstract contract Game {
    string homeTeam;
    string awayTeam;
    uint homeScore;
    uint awayScore;

    constructor(string memory _home, string memory _away){
        homeTeam = _home;
        awayTeam = _away;
    }

    function getHomeTeamScore() internal virtual view returns(uint);
    function getAwayTeamScore() internal virtual view returns(uint);

    function getWinningTeam() public view returns(string memory){
        if(homeScore>awayScore){
            return homeTeam;
        } else if(awayScore>homeScore){
            return awayTeam;
        }
    }
}

contract BasketballGame is Game {
    modifier score(uint _score){
        require(_score<4, "Invalid Score");
        require(_score>0, "Invalid Score");
        _;
    }

    constructor(string memory _home, string memory _away) Game(_home, _away){}

    function getHomeTeamScore() internal override view returns(uint){
        return homeScore;
    }
    function getAwayTeamScore() internal override view returns(uint){
        return awayScore;
    }

    function homeTeamScored(uint _score) external  score(_score) {
        homeScore += _score;
    }

    function awayTeamScored(uint _score) external score(_score) {
        awayScore += _score;
    }
}

contract SoccerGame is Game {
    constructor(string memory _home, string memory _away) Game(_home, _away){}

    function getHomeTeamScore() internal override view returns(uint){
        return homeScore;
    }
    function getAwayTeamScore() internal override view returns(uint){
        return awayScore;
    }

    function homeTeamScored() external {
        homeScore++;
    }

    function awayTeamScored() external {
        awayScore++;
    }
}