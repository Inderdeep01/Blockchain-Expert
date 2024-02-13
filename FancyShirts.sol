pragma solidity >=0.4.22 <=0.8.17;

contract FancyShirts {
    enum Size{S, M, L}

    enum Color {R, G, B }

    struct Shirt{
        Size size;
        Color color;
    }
    mapping (address => Shirt[]) closet;

    function getShirtPrice(Size size, Color color)public pure returns (uint) {
        uint price;
        if(size==Size.S){
            price += 10 wei;
        }
        else if(size==Size.M){
            price += 15 wei;
        }
        else if(size==Size.L){
            price += 20 wei;
        }
        if(color== Color.B || color==Color.G){
            price += 5 wei;
        }
        return price;
    }

    function buyShirt(Size size, Color color) external payable {
        uint price;
        if(size==Size.S){
            price += 10 wei;
        }
        else if(size==Size.M){
            price += 15 wei;
        }
        else if(size==Size.L){
            price += 20 wei;
        }
        if(color== Color.B || color==Color.G){
            price += 5 wei;
        }
        require(msg.value==price, "Invalid amount");
        closet[msg.sender].push(Shirt(size,color));        
    }

    function getShirts(Size size, Color color) public view returns (uint){
        uint shirts;
        uint n = closet[msg.sender].length;
        for(uint i;i<n;i++){
            if(closet[msg.sender][i].size==size && closet[msg.sender][i].color==color){
                shirts++;
            }
        }
        return shirts;
    }
}